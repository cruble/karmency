class CoinAlert < ActiveRecord::Base
  belongs_to :coin
  belongs_to :user


end
