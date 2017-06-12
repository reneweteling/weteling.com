ClientType = GraphQL::ObjectType.define do
  name "Client"
  description "Type for Client object"

  interfaces [::GraphQL::Relay::Node.interface]

  global_id_field :id
  field :address, GraphTypes::STRING, "Property `address` for Client"
  field :bic, GraphTypes::STRING, "Property `bic` for Client"
  field :city, GraphTypes::STRING, "Property `city` for Client"
  field :cocNo, GraphTypes::STRING, "Property `coc_no` for Client", property: :coc_no
  field :country, GraphTypes::STRING, "Property `country` for Client"
  field :createdAt, GraphTypes::DATETIME, "Property `created_at` for Client", property: :created_at
  field :department, GraphTypes::STRING, "Property `department` for Client"
  field :email, GraphTypes::STRING, "Property `email` for Client"
  field :firstName, GraphTypes::STRING, "Property `first_name` for Client", property: :first_name
  field :iban, GraphTypes::STRING, "Property `iban` for Client"
  field :ibanName, GraphTypes::STRING, "Property `iban_name` for Client", property: :iban_name
  field :lastName, GraphTypes::STRING, "Property `last_name` for Client", property: :last_name
  field :name, GraphTypes::STRING, "Property `name` for Client"
  field :postalcode, GraphTypes::STRING, "Property `postalcode` for Client"
  field :taxNo, GraphTypes::STRING, "Property `tax_no` for Client", property: :tax_no
  field :updatedAt, GraphTypes::DATETIME, "Property `updated_at` for Client", property: :updated_at
  field :userId, GraphTypes::INTEGER, "Property `user_id` for Client", property: :user_id

  # field :user, UserType, "Association to one `user` on Client"
  # connection :projects, ProjectType.connection_type, "Association to many `projects` on Client"
  # connection :hours, HourType.connection_type, "Association to many `hours` on Client"

end
