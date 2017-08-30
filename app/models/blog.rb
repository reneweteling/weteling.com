class Blog < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  def to_s
    title
  end

end
