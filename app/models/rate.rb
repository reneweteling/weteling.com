class Rate < ApplicationRecord
  belongs_to :user
  has_many :hours

  validates_presence_of :user, :name, :rate
end
