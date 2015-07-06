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
    moments_for_testing = Moment.all
    moments_for_testing.each do | moment |
      moment.giver = @user
      moment.save
    end

    expect(@user.moments_given).to eq(moments_for_testing)

  end

  it "has many moments as receiver" do

    moments_for_testing = Moment.all
    moments_for_testing.each do | moment |
      moment.receiver = @user
      moment.save
    end

    expect(@user.moments_received).to eq(moments_for_testing)

  end

  it "has many moments" do
    moments_as_giver = Moment.where("id < 3")

    moments_as_giver.each do |moment|
      moment.giver = @user
      moment.save
    end

    moment_as_receiver = Moment.find(1)

    moment_as_receiver.giver = @user
    moment_as_receiver.save

    expect(@user.moments.map {|moment| moment.id}).to eq(moments_as_giver.map {|moment| moment.id})
  end

  it "has many coins given" do

    moments_as_giver = Moment.where("id < 3")

    moments_as_giver.each do |moment|
      moment.giver = @user
      moment.save
    end

    expect(@user.coins_given.map {|coin| coin.id}).to eq(moments_as_giver.map {|moment| moment.coin.id})


  end

  it "has many coins received" do

    moments_as_receiver = Moment.where("id < 3")

    moments_as_receiver.each do |moment|
      moment.receiver = @user
      moment.save
    end

    expect(@user.coins_received.map {|coin| coin.id}).to eq(moments_as_receiver.map {|moment| moment.coin.id})

  end


  it "has many coins through moments" do

    moments_as_giver = Moment.where("id < 3")

    moments_as_giver.each do |moment|
      moment.giver = @user
      moment.save
    end

    moment_as_receiver = Moment.find(1)

    moment_as_receiver.giver = @user
    moment_as_receiver.save

    expect(@user.coins.map {|coin| coin.id}).to eq(moments_as_giver.map {|moment| moment.coin.id}.uniq)
  end

  it "can own a group (as creator)" do
    group = @groups.first
    group.creator = @user
    group.save

    @user = User.find(@user_id)

    expect(@user.groups_created.first).to eq(group)
  end

  it "belongs to many groups" do
    group = @groups.last
    group.users << @user
    group.save

    @user = User.find(@user_id)

    expect(@user.groups.size).to eq(1)
    expect(@user.groups.first).to eq(group)

  end

end
