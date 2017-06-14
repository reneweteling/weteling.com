class Hour < ApplicationRecord
  belongs_to :project
  belongs_to :rate
  has_one :client, through: :project
  has_one :user, through: :client

  validates_presence_of :project, :rate, :date, :total_hours, :description

  scope :orderd, -> {order(:date)}
end
