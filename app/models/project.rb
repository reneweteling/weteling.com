class Project < ApplicationRecord
  has_many :hours, dependent: :restrict_with_error
  has_and_belongs_to_many :tags
  belongs_to :client
  has_one :user, through: :client

  accepts_nested_attributes_for :tags
  mount_uploader :image, BaseImageUploader
  acts_as_list :position

  validates_presence_of :client, :name

  attr_writer :virtual_techniques_attr

  scope :orderd, -> { order(position: :desc) }
  scope :for_site, -> { site_active?.orderd }
  scope :for_cv, -> { cv_active?.order(end_date: :desc).order(start_date: :asc) }

  def techniques
    tags.join(',')
  end

  def techniques=(value)
    if value.class == String
      value = value.split(',')
    end
    self.tags = value.map{|t| Tag.find_or_initialize_by(name: t) }
  end

  def to_s
    "#{client} - #{name}"
  end
end
