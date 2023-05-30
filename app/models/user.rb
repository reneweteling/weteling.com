class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :clients, dependent: :restrict_with_error
  has_many :rates, dependent: :restrict_with_error
  has_many :projects, through: :clients
  has_many :hours, through: :projects  
  has_and_belongs_to_many :projects

  validates_presence_of :email, :name

  enum role: [:admin, :client]

  def to_s
    name
  end

  def generate_jwt
    JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end
end
