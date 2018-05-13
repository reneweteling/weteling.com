PDFKit.configure do |config|
  config.default_options = {
    page_size: 'A4',
    orientation: 'Portrait',
    print_media_type: false,
    dpi: 300,
    load_error_handling: 'ignore',
    load_media_error_handling: 'ignore',
    debug_javascript: true,
    enable_internal_links: true,
    enable_external_links: true,
    enable_toc_back_links: true,
    viewport_size: '1200x1024'
  }
  config.verbose = true
  # if Rails.env.development?
  #   config.root_url = "http://localhost/"
  # end
end
