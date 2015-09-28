class CreateCoinAlerts < ActiveRecord::Migration
  def change
    create_table :coin_alerts do |t|
      t.references :coin, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :coin_alerts, :coins
    add_foreign_key :coin_alerts, :users
  end
end
