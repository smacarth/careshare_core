class CreatePillData < ActiveRecord::Migration
  def change
    create_table :pill_data do |t|
      t.string   :name
      t.string   :image_url
      t.timestamps
    end
  end
end
