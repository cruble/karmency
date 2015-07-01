require 'rails_helper'

describe Coin, type: :model do

  let(:creator) { create(:user) }
  let(:coin) { create(:coin, creator: creator) }
  let(:users) { create_list(:users, 4) }
  let(:moments) { create_list(:moments, 4) }

  before(:each) do
    # associate moments with coin
    moments.each do |moment|
      moment.coin = coin
    end
    # associate users with moments
    moments.each_with_index do |moment, index|
      if index == 0
        moment.giver = creator
      else
        moment.giver = users[index - 1]
      end
      moment.receiver = users[index]
    end
  end

  it "has a creation date" do
    binding.pry
    expect(coin.created_at.class).to eq("datetime")
  end

  it "has a creation location" do
    expect(coin.creation_location).to eq("Test location for coin")
  end

  it "has a code" do
    expect(coin.code).to eq("1234")
  end

  it "has a creator" do
    expect(coin.creator).to eq(creator)
  end

  it "has many moments" do
    expect(coin.moments.size).to eq(4)
  end

  it "has many givers through moments" do
    expect(coin.givers.size).to eq(4)
  end

  it "has many receivers through moments" do
    expect(coin.receivers.size).to eq(4)
  end

end
