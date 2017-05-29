ViewerType = GraphQL::ObjectType.define do
  name "Viewer"
  description "Type for Viewer object"

  interfaces [::GraphQL::Relay::Node.interface]

  connection :users, UserType.connection_type, "Association to many `users` on Viewer"
  connection :clients, ClientType.connection_type, "Association to many `clients` on Viewer"
  connection :hours, HourType.connection_type, "Association to many `hours` on Viewer"
  connection :projects, ProjectType.connection_type, "Association to many `projects` on Viewer"
  connection :rates, RateType.connection_type, "Association to many `rates` on Viewer"

end
