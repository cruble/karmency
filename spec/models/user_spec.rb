require 'rails_helper'

describe User, type: :model do

  before(:all) do
    # create user with minimum attributes required
    @user = create(:user)
    @user_id = @user.id
    # add optional attributes
    @user.tagline = "hey it's me parker whooooooooooooa"
    @user.profile_url = "https://www.google.com"
    @user.location = "East Village, New York, 10009"
    @user.save

    # create other needed objects
    @coins = create_list(:coin, 5)
    @users = create_list(:user, 5)
    @moments = create_list(:moment, 5)
    @groups = create_list(:group, 5)

  end

  it "can be retrieved from database" do
    expect(User.find(@user_id)).to eq(@user)
    expect(User.find_by(tagline: "hey it's me parker whooooooooooooa")).to eq(@user)
  end

  it "has an email" do
    expect(@user.email).to match(/fakeemail\d+@example.com/)
  end

  it "has a tagline" do
    expect(@user.tagline).to eq("hey it's me parker whooooooooooooa")
  end

  it "has a profile URL" do
    expect(@user.profile_url).to eq("https://www.google.com")
  end

  it "has a location" do
    expect(@user.location).to eq("East Village, New York, 10009")
  end

  it "can own a created coin" do
    coin_for_testing = Coin.find(1)
    coin_for_testing.creator = @user
    coin_for_testing.save

    expect(@user.created_coins.first).to eq(coin_for_testing)
  end

  it "can own multiple created coins" do
    coins_for_testing = Coin.where("id < 3")

    coins_for_testing.each do |coin|
      coin.creator = @user
      coin.save
    end

    expect(@user.created_coins.size).to eq(2)
    expect(@user.created_coins).to eq(coins_for_testing)
  end

  it "has many moments as giver" do
    binding.pry
  end

  it "has many moments as receiver" do

  end

  it "has many coins through moments" do

  end

  it "owns many groups (as creator)" do

  end

  it "belongs to many groups" do

  end

end
