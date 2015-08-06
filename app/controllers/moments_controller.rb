class MomentsController < ApplicationController

  def new
    @moment = Moment.new()
    @coin = Coin.find(params[:coin_id])
  end

  def create
    date_array = moment_params['date'].split("/")
    date_array[2] = "20" + date_array[2]
    date_array.map! { |str| str.to_i }
    date = Date.new(date_array[2], date_array[0], date_array[1])

    if moment_params['giver_receiver'] == "receiver"
      receiver_id = current_user.id
      giver_id = nil
    else
      receiver_id = nil
      giver_id = current_user.id
    end

    @coin = Coin.find(params['coin_id'])

    @moment = Moment.create(
      coin_id: @coin.id,
      description: moment_params['description'],
      date: date,
      state: moment_params['state'],
      city: moment_params['city'],
      giver_id: giver_id,
      receiver_id: receiver_id
    )

  end

  def edit
    # lookup relevant moment
    @moment = Moment.find(params[:id])

    # get user if relevant
    if @user = current_user
    # check if moment needs giver / receiver
      if !@moment.giver
        @moment.giver = @user
        @response = @moment.save || "error - giver not added"
      elsif !@moment.receiver
        @moment.receiver = @user
        @response = @moment.save || "error - receiver not added"
      else
        @response = "error - already has giver and receiver"
      end
    else
      @response = "not logged in"
    end
  end

  private

  def moment_params
    params.require(:moment).permit(:description, :state, :city, :date, :giver_receiver)
  end

end
