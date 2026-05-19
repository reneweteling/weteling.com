class Project < ApplicationRecord
  has_many :hours, dependent: :restrict_with_error
  has_and_belongs_to_many :tags
  belongs_to :client
  has_one :user, through: :client

  accepts_nested_attributes_for :tags
  mount_uploader :image, BaseImageUploader
  acts_as_list :position

  validates_presence_of :client, :name
  validates_uniqueness_of :slug

  before_validation :generate_slug

  def to_param
    slug
  end

  attr_writer :virtual_techniques_attr

  scope :orderd,    -> { order(position: :asc) }
  scope :for_hours, -> { where(hours_active: true) }
  scope :for_site,  -> { where(site_active: true).orderd }
  scope :for_cv,    -> { where(cv_active: true).orderd }

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

  def budget?
    budget.present? && budget.positive?
  end

  def default_rate_amount
    client&.default_rate&.rate
  end

  def budget_hours
    return nil unless budget? && default_rate_amount&.positive?
    budget / default_rate_amount
  end

  def spent_amount(up_to: nil)
    scope = hours.includes(:rate)
    scope = scope.where(date: ..up_to) if up_to
    scope.sum { |h| h.total_hours * h.rate.rate }
  end

  def remaining_amount(up_to: nil)
    return nil unless budget?
    budget - spent_amount(up_to: up_to)
  end

  def remaining_hours(up_to: nil)
    remaining = remaining_amount(up_to: up_to)
    return nil unless remaining && default_rate_amount&.positive?
    remaining / default_rate_amount
  end

  private

  def generate_slug
    self.slug = (title.presence || name)&.parameterize if slug.blank?
  end
end
