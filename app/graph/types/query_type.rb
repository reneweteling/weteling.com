QueryType = GraphQL::ObjectType.define do

  name "Query"
  description "The query root of this schema"

  field :viewer do
    type ViewerType
    resolve -> (obj, args, ctx) {
      ctx[:viewer]
    }
  end

  field :node, ::GraphQL::Relay::Node.field
end
