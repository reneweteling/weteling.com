 ProjectType = GraphQL::ObjectType.define do
  
  name "Project"
  description "Type for Project object"

  interfaces [::GraphQL::Relay::Node.interface]

  global_id_field :id
  field :client, ClientType, "Association to one `client` on Project"
  connection :hours, HourType.connection_type, "Association to many `hours` on Project"

  field :clientId, GraphTypes::INTEGER, "Property `client_id` for Project", property: :client_id
  field :createdAt, GraphTypes::DATETIME, "Property `created_at` for Project", property: :created_at
  field :description, GraphTypes::TEXT, "Property `description` for Project"
  field :name, GraphTypes::STRING, "Property `name` for Project"
  field :updatedAt, GraphTypes::DATETIME, "Property `updated_at` for Project", property: :updated_at
  field :user, UserType, "Association to one `user` on Project"

end
