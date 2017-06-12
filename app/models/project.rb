class Project < ApplicationRecord
  has_many :hours
  belongs_to :client
  has_one :user, through: :client

  validates_presence_of :client, :name

  scope :orderd, -> { order(:name) }

  def to_s
    "#{client} - #{name}"
  end
end
