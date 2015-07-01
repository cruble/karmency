require 'rails_helper'

describe Coin, type: :model do

  let(:creator) { create(:user) }
  let(:coin) { create(:coin, creator_id: creator.id) }
  let(:users) { create_list(:user, 4) }
  let(:moments) { create_list(:moment, 4) }

  before(:each) do
    # associate moments with coin
    moments.each do |moment|
      coin.moments << moment
    end
    # associate users with moments
    moments.each_with_index do |moment, index|
      if index == 0
        coin.givers << creator
      else
        coin.givers << users[index - 1]
      end
      coin.receivers << users[index]
    end
  end

  it "has a creation date" do
    expect(coin.created_at.class).to eq(ActiveSupport::TimeWithZone)
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
    binding.pry 
    expect(coin.moments.size).to eq(4)
  end

  it "has many givers through moments" do
    expect(coin.givers.size).to eq(4)
  end

  it "has many receivers through moments" do
    expect(coin.receivers.size).to eq(4)
  end

end
