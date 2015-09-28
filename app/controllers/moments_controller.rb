class MomentsController < ApplicationController

  def new
    @moment = Moment.new()
    @coin = Coin.find(params[:coin_id])
    @coin_alert = CoinAlert.new()
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
      receiver_id: receiver_id, 
      alert_status: moment_params['alert_status'] 
    )

    # create the CoinAlert join object 
    if moment_params['alert_status'] == 'true'
      @coin_alert = CoinAlert.create(
        coin_id: @coin.id, 
        user_id: current_user.id,  
        status: true
        )
    end 
    # find all the alerts 
    @alerts = CoinAlert.where(coin_id: @coin.id)
    # make sure you have one record per user (in case a user has multiple 
    # moments - unlikely, but could happen the way we are set up now)
    @uniq_alerts = @alerts.select(:user_id).distinct
    if @uniq_alerts
          @uniq_alerts.select do | alert |
            user = User.find(alert.user_id)
            #sends the mail to each user with an alert for this coin
            #am sending this for each user, rather than bcc'ing one email 
            #to a list of users. Figure this is OK for now. 
            UserMailer.moment_mail(current_user, @coin).deliver_later
          end
    end 

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
    params.require(:moment).permit(:description, :state, :city, :date, :giver_receiver, :alert_status)
  end

end
