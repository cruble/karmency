class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.references :coin, index: true
      t.text :description
      t.date :date
      t.string :city
      t.string :state
      t.string :location
      t.string :photo_url

      t.timestamps null: false
    end
    add_foreign_key :moments, :coins
  end
end
