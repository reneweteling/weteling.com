class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :hours, through: :projects
  belongs_to :user

  validates_presence_of :user, :name
end
