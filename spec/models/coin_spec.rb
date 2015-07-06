require 'rails_helper'

describe Coin, type: :model do

  before(:all) do
    @creator = create(:user)
    @coin = create(:coin, creator_id: @creator.id)
    @users = create_list(:user, 4)
    @moments = create_list(:moment, 4)

    # for each moment add a giver and receiver to a coin

    @moments.each_with_index do |moment, index|
      if index == 0
        moment.giver = @creator
      else
        moment.giver = @users[index - 1]
      end

      moment.receiver = @users[index]
    end

    # associate moments with coin
    @moments.each do |moment|
      @coin.moments << moment
    end

  end

  it "has a creation date" do
    expect(@coin.created_at.class).to eq(ActiveSupport::TimeWithZone)
  end

  it "has a creation location" do
    expect(@coin.creation_location).to eq("Test location for coin")
  end

  it "has a code" do
    expect(@coin.code).to eq("1234")
  end

  it "has a creator" do
    expect(@coin.creator).to eq(@creator)
  end

  it "has many moments" do
    expect(@coin.moments.size).to eq(4)
  end

  it "has many givers through moments" do
    expect(@coin.givers.size).to eq(4)
  end

  it "has many receivers through moments" do
    expect(@coin.receivers.size).to eq(4)
  end

end
