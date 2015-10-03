class CreateReservedCodes < ActiveRecord::Migration
  def change
    create_table :reserved_codes do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end
