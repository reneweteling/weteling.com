class Subscriber < ApplicationRecord
  validates :email, email: true
  validates_presence_of :first_name, :email
end
