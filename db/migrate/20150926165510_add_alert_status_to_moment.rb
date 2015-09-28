class AddAlertStatusToMoment < ActiveRecord::Migration
  def change
    add_column :moments, :alert_status, :boolean
  end
end
