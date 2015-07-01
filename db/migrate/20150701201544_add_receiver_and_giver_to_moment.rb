class AddReceiverAndGiverToMoment < ActiveRecord::Migration
  def change
    add_column :moments, :receiver_id, :integer
    add_column :moments, :giver_id, :integer
  end
end
