class CreateFrequencies < ActiveRecord::Migration
  def change
    create_table :frequencies do |t|
      t.references  :pill
      t.string      :name
      t.timestamps
    end
    add_index :frequencies, [:pill_id]
  end
end
