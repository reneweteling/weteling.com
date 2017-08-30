class Tag < ApplicationRecord
  has_and_belongs_to_many :blogs
  
  def to_s
    name
  end
  
end
