UserType = GraphQL::ObjectType.define do
  name "User"
  description "Type for User object"

  interfaces [::GraphQL::Relay::Node.interface]

  global_id_field :id
  connection :clients, ClientType.connection_type, "Association to many `clients` on User"
  connection :hours, HourType.connection_type, "Association to many `hours` on User"
  connection :projects, ProjectType.connection_type, "Association to many `projects` on User"
  connection :rates, RateType.connection_type, "Association to many `rates` on User"

  field :address, GraphTypes::STRING, "Property `address` for User"
  field :bic, GraphTypes::STRING, "Property `bic` for User"
  field :city, GraphTypes::STRING, "Property `city` for User"
  field :cocNo, GraphTypes::STRING, "Property `coc_no` for User", property: :coc_no
  field :country, GraphTypes::STRING, "Property `country` for User"
  field :createdAt, GraphTypes::DATETIME, "Property `created_at` for User", property: :created_at
  field :currentSignInAt, GraphTypes::DATETIME, "Property `current_sign_in_at` for User", property: :current_sign_in_at
  field :currentSignInIp, GraphTypes::STRING, "Property `current_sign_in_ip` for User", property: :current_sign_in_ip
  field :department, GraphTypes::STRING, "Property `department` for User"
  field :email, GraphTypes::STRING, "Property `email` for User"
  field :encryptedPassword, GraphTypes::STRING, "Property `encrypted_password` for User", property: :encrypted_password
  field :firstName, GraphTypes::STRING, "Property `first_name` for User", property: :first_name
  field :iban, GraphTypes::STRING, "Property `iban` for User"
  field :ibanName, GraphTypes::STRING, "Property `iban_name` for User", property: :iban_name
  field :lastName, GraphTypes::STRING, "Property `last_name` for User", property: :last_name
  field :lastSignInAt, GraphTypes::DATETIME, "Property `last_sign_in_at` for User", property: :last_sign_in_at
  field :lastSignInIp, GraphTypes::STRING, "Property `last_sign_in_ip` for User", property: :last_sign_in_ip
  field :name, GraphTypes::STRING, "Property `name` for User"
  field :postalcode, GraphTypes::STRING, "Property `postalcode` for User"
  field :rememberCreatedAt, GraphTypes::DATETIME, "Property `remember_created_at` for User", property: :remember_created_at
  field :resetPasswordSentAt, GraphTypes::DATETIME, "Property `reset_password_sent_at` for User", property: :reset_password_sent_at
  field :resetPasswordToken, GraphTypes::STRING, "Property `reset_password_token` for User", property: :reset_password_token
  field :signInCount, GraphTypes::INTEGER, "Property `sign_in_count` for User", property: :sign_in_count
  field :taxNo, GraphTypes::STRING, "Property `tax_no` for User", property: :tax_no
  field :updatedAt, GraphTypes::DATETIME, "Property `updated_at` for User", property: :updated_at

end
