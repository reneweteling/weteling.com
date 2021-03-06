Rails.application.configure do 
  # Be sure to restart your server when you modify this file.

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Add additional assets to the asset load path
  # Rails.application.config.assets.paths << Emoji.images_path

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # Rails.application.config.assets.precompile += %w( search.js )

  config.assets.precompile += %w( pdf.css )
  config.assets.precompile += %w( site.css site.js )
  config.assets.precompile += %w( ckeditor/* )

  config.public_file_server.headers = {
    'Access-Control-Allow-Origin' => '*'
  }
end
