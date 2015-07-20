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

  def formatted_date
    "#{month} #{day}, #{year}"
  end

  def image_url
    if receiver && receiver.image_url
      receiver.image_url
    elsif receiver
      "/img/default_face.png"
    else
      "/img/anonymous_face.jpg"
    end
  end

  def formatted_location
    if !city || !state
      "Unknown"
    elsif state == "Non-U.S."
      "Non-U.S."
    else
      "#{city}, #{state}"
    end
  end

  private

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

  def year
    if date
      date.strftime("%Y")
    else
      created_at.strftime("%Y")
    end
  end

end
