ProjectType = GraphQL::ObjectType.define do
  name "Project"
  field :name, !types.String
  field :description, !types.String
  field :hours, types[HourType]
  field :client, ClientType
end
