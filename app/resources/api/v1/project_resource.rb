module Api
  module V1
    class ProjectResource < JSONAPI::Resource
      attributes :name
      has_many :hours
    end
  end
end