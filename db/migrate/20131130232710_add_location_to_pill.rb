class AddLocationToPill < ActiveRecord::Migration
  def change
    add_column :pills, :location, :string
  end
end
