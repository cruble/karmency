FactoryGirl.define do
  factory :moment do
    description "He gave up his subway seat"
    date "2015-07-01"
    location "Grand Army Plaza"
    photo_url "https://www.google.com/"
    coin {Coin.first}
  end
end
