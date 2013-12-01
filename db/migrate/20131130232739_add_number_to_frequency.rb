class AddNumberToFrequency < ActiveRecord::Migration
  def change
    add_column :frequencies, :number, :integer
  end
end
