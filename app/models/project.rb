class Project < ApplicationRecord
  has_many :hours, dependent: :destroy
  belongs_to :client
  has_one :user, through: :client

  validates_presence_of :client, :name
end
