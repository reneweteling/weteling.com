class Project < ApplicationRecord
  has_many :hours, dependent: :restrict_with_exception
  belongs_to :client
  has_one :user, through: :client

  validates_presence_of :client, :name
end
