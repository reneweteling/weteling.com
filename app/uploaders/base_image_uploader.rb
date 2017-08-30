class BaseImageUploader < BaseUploader
  def initialize(*)
    super
    self.aws_acl    = 'public-read'
  end

  include CarrierWave::MiniMagick
  version :thumb do
    process resize_to_fill: [500, 500]
  end

  version :large do
    process resize_to_limit: [1024, 1024]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end    
end
