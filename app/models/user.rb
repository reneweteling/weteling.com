class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :clients, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :projects, through: :clients
  has_many :hours, through: :projects  

  validates_presence_of :email, :name
end
