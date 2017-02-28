UserType = GraphQL::ObjectType.define do
  name "User"
  description "An user"
  field :name, types.String
  field :first_name, types.String
  field :last_name, types.String
  field :department, types.String
  field :address, types.String
  field :postalcode, types.String
  field :city, types.String
  field :country, types.String
  field :email, types.String
  field :iban, types.String
  field :bic, types.String
  field :iban_name, types.String
  field :coc_no, types.String
  field :tax_no, types.String
  field :title, types.String
  field :content, types.String
  # field :clients, types[!ClientType]
  # field :rates, types[!RateType]
end