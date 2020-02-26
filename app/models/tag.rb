class Tag < ApplicationRecord
  has_and_belongs_to_many :blogs
  has_and_belongs_to_many :projects
  
  def to_s
    name
  end
  
end
