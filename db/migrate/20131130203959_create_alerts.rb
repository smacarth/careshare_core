class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references  :period
      t.boolean     :took
      t.timestamps
    end
    #add_index :alerts, [:period_id]
  end
end
