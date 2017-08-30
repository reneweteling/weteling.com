namespace :blog do
  task import: :environment do

    require 'csv'    
    
    CSV.foreach(Rails.root.join('vendor/blog.csv'), :headers => true) do |row|
      r = row.to_hash
      Blog.create!(name: r['post_title'], date: r['post_date'], content: r['post_content'], remote_image_url: r['guid'])
    end

  end
end
