class Coin < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :group
  has_many :moments
  has_many :receivers, through: :moments, class_name: "User"
  has_many :givers, through: :moments, class_name: "User"




end
