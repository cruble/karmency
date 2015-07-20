class AddDetailedLocationToCoin < ActiveRecord::Migration
  def change
    add_column :coins, :city, :string
    add_column :coins, :state, :string
  end
end
