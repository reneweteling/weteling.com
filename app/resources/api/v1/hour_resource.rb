module Api
  module V1
    class HourResource < JSONAPI::Resource
      attributes :project, :rate, :date, :total_hours, :description
      # belongs_to :rate
      # has_one :client, through: :project
      # has_one :user, through: :client
    end
  end
end
