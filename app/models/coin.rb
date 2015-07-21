class Coin < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :group
  has_many :moments
  has_many :receivers, through: :moments, class_name: "User"
  has_many :givers, through: :moments, class_name: "User"

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

end
