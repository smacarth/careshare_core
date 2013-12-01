class Pill < ActiveRecord::Base
  has_one :frequency
  has_many :periods
  belongs_to :user
  belongs_to :pill_data
  belongs_to :unit
end
