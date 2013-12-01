# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'    

file = File.join(Rails.root, 'lib', 'data', 'meds.csv')

csv = CSV.parse(File.read(file), :headers => true)
csv.each do |row|
  PillData.create(:name => row[9])
end
