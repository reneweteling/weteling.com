class CkeditorAttachmentFileUploader < BaseUploader
  include Ckeditor::Backend::CarrierWave

  def initialize(*)
    super
    self.aws_acl    = 'public-read'
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    Ckeditor.attachment_file_types
  end
end
