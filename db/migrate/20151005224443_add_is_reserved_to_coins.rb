class AddIsReservedToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :is_reserved, :boolean, :default => false
  end
end
