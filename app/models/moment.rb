class Moment < ActiveRecord::Base
  belongs_to :coin
  belongs_to :receiver, :class_name => "User"
  belongs_to :giver, :class_name => "User"

  def receiver_name
    if receiver
      receiver.formatted_name
    else
      "Anonymous"
    end
  end

  def day
    if date
      date.day
    else
      created_at.day
    end
  end

  def month
    if date
      date.strftime("%b")
    else
      created_at.strftime("%b")
    end
  end

end
