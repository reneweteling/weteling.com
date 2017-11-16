class Project < ApplicationRecord
  has_many :hours, dependent: :restrict_with_error
  belongs_to :client
  has_one :user, through: :client

  mount_uploader :image, BaseImageUploader
  acts_as_list :position

  validates_presence_of :client, :name

  scope :orderd, -> { order(position: :asc) }
  scope :for_site, -> { orderd.where(show: true) }
  scope :for_cv, -> { orderd.where(show: true).limit(5) }


  def to_s
    "#{client} - #{name}"
  end
end
