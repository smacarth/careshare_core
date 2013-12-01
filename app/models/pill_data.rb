class PillData < ActiveRecord::Base
  has_many :pills
  
  def self.search_pills(query)
    data = PillData.where("UPPER(name) LIKE UPPER(?)", "%#{query}%").select(:id, :name)
  end
end