class Coin < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :group
  has_many :moments
  has_many :receivers, through: :moments, class_name: "User"
  has_many :givers, through: :moments, class_name: "User"
  has_many :coin_alerts
  accepts_nested_attributes_for :coin_alerts, allow_destroy: true


  def formatted_location
    if !city || !state
      "Unknown"
    elsif state == "Non-U.S."
      "Non-U.S."
    else
      "#{city}, #{state}"
    end
  end

  def num_moments
    moments.size
  end

  def last_transaction_location
    if moments.size > 0
      moments.last.formatted_location
    else
      formatted_location
    end
  end

  def formatted_date
    "#{created_at.strftime("%B")} #{created_at.day}, #{created_at.year}"
  end

  def avg_trans_time
    total_time = 0
    moments.reverse.inject(moments.last) do |memo, moment|
      unless memo == moment
        total_time += memo.date - moment.date
        memo = moment
      end
      memo
    end

    if moments.size > 0
      "#{(total_time / (moments.size - 1)).to_i} days"
    else
      "N/A"
    end
  end

  def user_alert_status(current_user)
    coin_alert = CoinAlert.where(coin_id: self.id, user_id: current_user.id)
    if coin_alert
      if coin_alert.last.status == true
       "On"
      else
       "Off"
      end
    end


 
  end 

  def last_coin_alert(current_user)
    coin_alerts = CoinAlert.where(coin_id: self.id, user_id: current_user.id)
    coin_alerts.last
  end 

  def toggle_alert_status(current_user)
    coin_alerts = CoinAlert.where(coin_id: self.id, user_id: current_user.id)
    coin_alerts.last.toggle!(:status)
  end 


end
