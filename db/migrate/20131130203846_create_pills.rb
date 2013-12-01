class CreatePills < ActiveRecord::Migration
  def change
    create_table :pills do |t|
      t.references  :user
      t.references  :pill_data
      t.integer     :dosage_amount
      t.references  :unit
      t.timestamps
    end
    add_index :pills, [:user_id, :pill_data_id]
  end
end
