class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.references  :pill
      t.datetime    :time_of_day
      t.timestamps
    end
    add_index :periods, [:pill_id]
  end
end
