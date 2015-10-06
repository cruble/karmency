class CoinsController < ApplicationController

  def lookup
  end

  def index

    if params[:my_coins] || user_signed_in?
      @coins = (current_user.coins + Coin.where(creator_id: current_user.id)).uniq 
    else
      @coins = Coin.last(25)
    end
    #@coin_alert = @coin.last_coin_alert(current_user)
    respond_to do |format|
      format.json {render json: {result: !!@coin}}
      format.html {}
      format.js {}
    end

  end

  def new
    @coin = Coin.new()
  end

  def create

    if current_user.coins_made_last_24 >= 25
      flash[:alert] = "Sorry, but you can only mint 25 coins during a 24-hour period. If you are an educator and need to mint a large batch of coins. Please reach out to team@karmency.org"
      render :js => "window.location = '/coins?my_coins=true'" and return
    end 

    @coin = Coin.new(coin_params)
    # need to checking if that code (or next sequential) is reserved
    # this blocks web users from using reserved codes. 
    next_unreserved_code = Coin.where(is_reserved: false).last.code


    next_code_temp = next_code(next_unreserved_code)
    # now we check that the next code is not reserved, skip until it is
    while ReservedCode.where(code: next_code_temp).first
      next_code_temp = next_code(next_code_temp)
    end 
    @coin.code = next_code_temp
    @coin.creator = current_user
    @coin.save
    # is_reserved defaults to true. maybe a different logic for admins?  
    # or we just create coins in the console
    CoinAlert.create(coin_id: @coin.id, user_id: current_user.id, status: true)
    
  end

  def show
    if params[:code]
      @coin = Coin.find_by(code: params[:code])
    else
      @coin = Coin.find_by(code: params[:id])
    end

    @moments = @coin.moments if @coin

    respond_to do |format|
      format.json {render json: {result: !!@coin}}
      format.html {}
    end

  end


  def toggle_alert_status 
    @coin_alert = CoinAlert.where(coin_id: params[:id], user_id: current_user.id).last
    @coin_alert.toggle!(:status)
    @coin = Coin.find(params[:id])
    
    respond_to do |f|
      f.js
    end
 
  end 

  private

  def coin_params
    params.require(:coin).permit(:description, :state, :city)
  end

  def next_code(last_code)
    # create hex alphabet - 4 digits
    values =  ("0".."9").to_a + ("A".."Z").to_a

    # lose the I and O because they look like 1 and 0, confusing 
    values.delete("I")
    values.delete("O")

    last_code_array = last_code.split(//)

    #let's find out the index for each digit 

    d_1 = values.index(last_code_array[0])
    d_2 = values.index(last_code_array[1])
    d_3 = values.index(last_code_array[2])
    d_4 = values.index(last_code_array[3])
    #first digit increment 
    if d_4 < 34   
      d_4 += 1
    end 

    #first digit flip when hits last value of array  
    if d_4 == 34 
      d_4 = 0 
      if d_3 < 33
        d_3 += 1
        #second digit flip 
      elsif d_3 == 33
        d_3 = 0 
        if d_2 < 33 
          d_2 += 1 
            #third digit flip 
          elsif d_2 == 33 
            d_2 = 0 
            if d_1 < 33
              d_1 += 1 

            elsif d_1 == 33 
              d_1 = 33
              puts "yikes that's the end of the codes"
            end 
          end 
        end
      end
      new_code = values[d_1].to_s + values[d_2].to_s + values[d_3].to_s + values[d_4].to_s

    end 

  # Parker's code.. was topping out at 9999 after about 3000 codes. Refactored above 
  # def next_code(last_code)
  #   # create hex alphabet
  #   values = ("A".."Z").to_a + ("0".."9").to_a

  #   # delete problematic characters
  #   values.delete("I") # I because it looks like 1 and is too left aligned
  #   values.delete("O") # O because it looks like 0

  #   updated = false
  #   next_code = []
  #   last_code.split(//).reverse.each_with_index { |digit, index|
  #     if digit != values.last && updated == false
  #       next_code[index-1] = values.first unless index == 0
  #       next_code.unshift(values[values.index(digit) + 1])
  #       updated = true
  #     else
  #       next_code.unshift(digit)
  #     end
  #   }
  #   next_code.join
  # end


end
