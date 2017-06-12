QueryType = GraphQL::ObjectType.define do

  name "Query"
  description "The query root of this schema"

  # field :viewer do
  #   type ViewerType
  #   resolve -> (obj, args, ctx) {
  #     ctx[:viewer]
  #   }
  # end

  field :me do 
    type UserType
    description "Current signed in user"
    resolve -> (obj, args, ctx) {
      current_user
    }
  end

  # field :user do 
  #   argument :id, types.ID 
  #   type UserType
  #   resolve -> (obj, args, ctx) {
  #     User.find args[:id]
  #   }
  # end

  # field :users do
  #   argument :ids, types.Int.to_list_type
  #   type UserType.to_list_type
  #   resolve -> (obj, args, ctx) {
  #     User.all
  #   }
  # end

  field :node, ::GraphQL::Relay::Node.field
end
