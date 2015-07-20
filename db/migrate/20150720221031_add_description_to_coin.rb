class AddDescriptionToCoin < ActiveRecord::Migration
  def change
    add_column :coins, :description, :string
  end
end
