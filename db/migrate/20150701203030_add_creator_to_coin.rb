class AddCreatorToCoin < ActiveRecord::Migration
  def change
    add_column :coins, :creator_id, :integer
  end
end
