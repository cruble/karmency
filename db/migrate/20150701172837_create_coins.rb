class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.string :creation_location
      t.string :code

      t.timestamps null: false
    end
  end
end
