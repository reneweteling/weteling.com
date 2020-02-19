WetelingComSchema = GraphQL::Schema.define do
  # mutation(Types::MutationType)
  query(QueryType)
  use GraphQL::Batch
end
