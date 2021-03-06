class Rate < ApplicationRecord
  belongs_to :user
  has_many :hours, dependent: :restrict_with_error

  validates_presence_of :user, :name, :rate

  def to_s
    "#{name} - #{rate}"
  end 

end
