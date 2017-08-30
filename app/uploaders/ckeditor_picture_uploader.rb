class CkeditorPictureUploader < ImageUploader
  include Ckeditor::Backend::CarrierWave

  process :extract_dimensions

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    Ckeditor.image_file_types
  end
end
