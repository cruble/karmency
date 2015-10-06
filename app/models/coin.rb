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
    if moments.size > 0 
      total_time += (moments.last.created_at - created_at)
    end 


    if moments.size == 0
      "N/A"
      "#{(total_time / (moments.size - 1)).to_i} days"
    elsif moments.size == 1
      days = ((moments.last.created_at - created_at) / (24*60*60)).round(2)
      "#{days} days"
    elsif moments.size > 1 
      moments.reverse.inject(moments.last) do |memo, moment|
        unless memo == moment
          total_time += memo.created_at - moment.created_at
          memo = moment
        end
        memo
      end
      avg_total = total_time / moments.size
      days = avg_total / (24*60*60)
      "#{days.round(2)} days"
    end
  end

  def num_states 
    if moments.size > 0
      self.moments.select(:state).uniq.count
    else
      1
    end
  end 

  def num_cities 
    if moments.size > 0
      self.moments.select(:city).uniq.count
    else
      1
    end
  end 


  def user_alert_status(current_user)
    coin_alert = CoinAlert.where(coin_id: self.id, user_id: current_user.id)
    if coin_alert.last
      if coin_alert.last.status == true
       "On"
      else
       "Off"
      end
    else 
      "N/A"
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
