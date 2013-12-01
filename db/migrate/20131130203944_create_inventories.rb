class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.references :pill
      t.datetime   :prescription_date
      t.integer    :number_of_pills
      t.integer    :refills
      t.timestamps
    end
    add_index :inventories, [:pill_id]
  end
end
