class Group < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :groups_users
  has_many :users, through: :groups_users

  after_create :add_creator_as_member

  private 

  def add_creator_as_member 

    self.users << self.creator
  end 


end
