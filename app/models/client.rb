class Client < ApplicationRecord
  has_many :projects, dependent: :restrict_with_error
  has_many :hours, through: :projects
  belongs_to :user

  validates_presence_of :user, :name

  def to_s
    name 
  end
  

end
