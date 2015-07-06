class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :groups_users
  has_many :groups, through: :groups_users
  has_many :created_coins, foreign_key: "creator_id", class_name: "Coin"
  has_many :moments_given, foreign_key: "giver_id", class_name: "Moment"
  has_many :moments_received, foreign_key: "receiver_id", class_name: "Moment"
  has_many :coins_given, through: :moments_given, foreign_key: "giver_id", source: :coin
  has_many :coins_received, through: :moments_received, foreign_key: "receiver_id", source: :coin
  has_many :groups_created, foreign_key: "creator_id", class_name: "Group"

  def moments
    Moment.where("receiver_id = ? OR giver_id = ?", self.id, self.id)
  end

  def coins
    coin_ids = moments.map do |moment|
      moment.coin_id
    end
    Coin.find(coin_ids)
  end

end
