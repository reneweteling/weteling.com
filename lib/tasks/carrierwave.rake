namespace :carrierwave do

  task recreate_versions: :environment do
    ENV['ROLE'] = 'worker'
    Project.all.each do |project|
      project.image.recreate_versions! if project.image?
      puts project.id
    end
  end
end