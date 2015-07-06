class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :tagline, :text
    add_column :users, :profile_url, :string
    add_column :users, :location, :text
  end
end
