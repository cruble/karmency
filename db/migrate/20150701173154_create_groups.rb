class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :location
      t.text :description
      t.string :photo_url

      t.timestamps null: false
    end
  end
end
