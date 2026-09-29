class App < ApplicationRecord
  mount_uploader :image, BaseImageUploader
  acts_as_list :position

  validates_presence_of :name, :url

  scope :orderd,   -> { order(position: :asc) }
  scope :for_site, -> { where(active: true).orderd }

  def tagline
    localized(:tagline)
  end

  def description
    localized(:description)
  end

  def to_s
    name
  end

  private

  # Falls back to the Dutch copy when the English one is still empty.
  def localized(attr)
    self["#{attr}_#{I18n.locale}"].presence || self["#{attr}_nl"]
  end
end
