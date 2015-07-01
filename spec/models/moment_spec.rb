require 'rails_helper'

describe Moment, type: :model do

  let(:coin) { create(:coin) }
  let(:receiver) { create(:user) }
  let(:giver) { create(:user) }
  let(:moment) { create(:moment, receiver: receiver, giver: giver) }

 it "has a description" do
    expect(moment.description).to eq("He gave up his subway seat")
  end

  it "has a date" do
    expect(moment.date.class).to eq("datetime")
  end

  it "has a location" do
    expect(moment.location).to eq("Grand Army Plaza")
  end

  it "has a photo_url" do
    expect(moment.photo_url).to eq("https://www.google.com/")
  end

  it "has a receiver" do
    expect(moment.receiver).to eq(receiver)
  end

  it "has a giver" do
    expect(moment.giver).to eq(giver)
  end

end
