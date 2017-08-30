class ImageUploader < BaseUploader
  def initialize(*)
    super
    self.aws_acl    = 'public-read'
  end

  include CarrierWave::MiniMagick

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [118, 100]
  end

  version :content do
    process resize_to_limit: [800, 800]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    Ckeditor.image_file_types
  end
end
