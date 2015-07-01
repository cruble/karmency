require 'rails_helper'

describe Group, type: :model do
  let(:creator) { create(:user) }
  let(:members) { create_list(:user, 5) }
  let(:group) { create(:group, creator: creator) }

  before(:each) do 
    members.each do |member|
      group.users << member 
    end 
  end 



  it "has a name" do
    expect(group.name).to eq("My Test Group")
  end

  it "has a location" do
    expect(group.location).to eq("101 South Lane, Brooklyn NY")
  end

  it "has a description" do
    expect(group.description).to eq("This is a test group it's only a test group do not adjust your expectations of this application")
  end

  it "has a photo_url" do
    expect(group.photo_url).to eq("https://wwww.google.com/")
  end

  it "belongs to a user as creator" do
    expect(group.creator).to eq(creator)
  end



  it "can have many users as members" do

    expect(group.users.size).to eq(6)
  end

  it "can access the members" do
    members.each do |member|
      expect(group.users).to include(member)
    end 
  end

  it "includes the creator as a member" do 
    expect(group.users).to include(creator)  
  end 


end
