HourType = GraphQL::ObjectType.define do
  name "Hour"
  description "Type for Hour object"

  field :client, ClientType, "Association to one `client` on Hour"
  field :project, ProjectType, "Association to one `project` on Hour"
  field :rate, RateType, "Association to one `rate` on Hour"
  field :user, UserType, "Association to one `user` on Hour"

  field :createdAt, GraphTypes::DATETIME, "Property `created_at` for Hour", property: :created_at
  field :date, GraphTypes::DATE, "Property `date` for Hour"
  field :description, GraphTypes::TEXT, "Property `description` for Hour"
  field :total_hours, GraphTypes::DECIMAL, "Property `hours` for Hour"
  field :projectId, GraphTypes::INTEGER, "Property `project_id` for Hour", property: :project_id
  field :rateId, GraphTypes::INTEGER, "Property `rate_id` for Hour", property: :rate_id
  field :updatedAt, GraphTypes::DATETIME, "Property `updated_at` for Hour", property: :updated_at
  
end
