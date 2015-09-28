class AddStatusToCoinAlerts < ActiveRecord::Migration
  def change
    add_column :coin_alerts, :status, :boolean
  end
end
