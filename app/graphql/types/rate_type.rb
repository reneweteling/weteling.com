 RateType = GraphQL::ObjectType.define do
  name "Rate"
  description "Type for Rate object"

  field :description, GraphTypes::TEXT, "Property `description` for Rate"
  field :name, GraphTypes::STRING, "Property `name` for Rate"
  field :rate, GraphTypes::DECIMAL, "Property `rate` for Rate"
end
