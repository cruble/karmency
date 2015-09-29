class CoinsController < ApplicationController

  def lookup
  end

  def index
    if params[:my_coins]
      @coins = current_user.coins
    else
      @coins = Coin.all
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
    @coin = Coin.new(coin_params)
    @coin.code = next_code(Coin.last.code)
    @coin.creator = current_user
    @coin.save
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
    # create hex alphabet
    values = ("A".."Z").to_a + ("0".."9").to_a

    # delete problematic characters
    values.delete("I") # I because it looks like 1 and is too left aligned
    values.delete("O") # O because it looks like 0

    updated = false
    next_code = []
    last_code.split(//).reverse.each_with_index { |digit, index|
      if digit != values.last && updated == false
        next_code[index-1] = values.first unless index == 0
        next_code.unshift(values[values.index(digit) + 1])
        updated = true
      else
        next_code.unshift(digit)
      end
    }
    next_code.join
  end




end
