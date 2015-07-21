class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

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

  def formatted_name
    if first_name
      if last_name
        first_name.capitalize + " " + last_name[0].upcase + "."
      else
        first_name.capitalize
      end
    else
      "Anonymous"
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "no_email@example.com" # TODO: consider other strategies here
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(" ").first
      user.last_name = auth.info.name.split(" ").last   # assuming the user model has a name
      user.image_url = auth.info.image # assuming the user model has an image
    end
  end

end
