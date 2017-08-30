class Blog < ApplicationRecord
  mount_uploader :image, BaseImageUploader
  validates_uniqueness_of :slug
  before_validation :set_slug

  has_and_belongs_to_many :tags

  def tag_tags
    tags.join(',')
  end

  def tag_tags=(value)
    if value.class == String
      value = value.split(',')
    end
    self.tags = value.map{|t| Tag.find_or_initialize_by(name: t) }
  end
  
  def to_s
    name
  end
  
  private
  
  def set_slug
    return unless slug.nil?
    self.slug = name.parameterize
  end

end
