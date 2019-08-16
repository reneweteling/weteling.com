# frozen_string_literal: true

class Hour < ApplicationRecord
  belongs_to :project
  belongs_to :rate
  has_one :client, through: :project
  has_one :user, through: :client

  validates :project, :rate, :date, :total_hours, :description, presence: true

  scope :orderd, -> { order(:date) }

  attr_accessor :repeat_date

  after_save :create_repeated_hours

  def create_repeated_hours
    return unless repeat_date
    return if repeat_date.empty?
    end_date = Date.parse(repeat_date)
    return if end_date < date

    start_date = date
    while end_date > start_date do
        start_date += 1.day
        Hour.find_or_create_by(project: project, rate: rate, date: start_date, description: description, total_hours: total_hours)
    end
  end
end
