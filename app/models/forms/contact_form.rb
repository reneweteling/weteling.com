class ContactForm
  include ActiveModel::Model
  extend ActiveModel::Translation


  attr_accessor :name, :email, :subject, :message
  validates :email, email: true
  validates_presence_of :name, :email, :subject, :message
end
