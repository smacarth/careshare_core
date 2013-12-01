class Period < ActiveRecord::Base
  belongs_to :pill
  has_many :alerts
end
