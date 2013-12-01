class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :phone
      t.string   :pharmacy
      t.string   :pharmacy_phone
      t.integer  :caretaker_id
      t.timestamps
    end
    add_index :users, [:caretaker_id]
  end
end
