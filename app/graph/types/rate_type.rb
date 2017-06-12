 RateType = GraphQL::ObjectType.define do
  name "Rate"
  description "Type for Rate object"

  interfaces [::GraphQL::Relay::Node.interface]

  global_id_field :id
  connection :hours, HourType.connection_type, "Association to many `hours` on Rate"
  field :user, UserType, "Association to one `user` on Rate"

  field :createdAt, GraphTypes::DATETIME, "Property `created_at` for Rate", property: :created_at
  field :description, GraphTypes::TEXT, "Property `description` for Rate"
  field :name, GraphTypes::STRING, "Property `name` for Rate"
  field :rate, GraphTypes::DECIMAL, "Property `rate` for Rate"
  field :updatedAt, GraphTypes::DATETIME, "Property `updated_at` for Rate", property: :updated_at
  field :userId, GraphTypes::INTEGER, "Property `user_id` for Rate", property: :user_id

end
