namespace :dokku do 
  task rebuild_local: :environment do

    raise "WTF!!! dude only in development!!!" unless Rails.env.development?

    backups = `aws s3 ls dokku.weteling.com | grep postgres-weteling`
    backup = backups.split("\n").last.split(/\s/).last

    raise "No backup" unless backup.present?

    # download latest backup
    run_command "aws s3 cp s3://dokku.weteling.com/#{backup} prod.tgz"

    # untar
    run_command 'mkdir _backup'
    run_command 'tar -xvzf prod.tgz -C ./_backup'
    run_command 'rm prod.tgz'

    # prepare db
    system("rake pg:disconnect RAILS_ENV=test")
    Rake::Task["pg:disconnect"].invoke
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    db = Rails.configuration.database_configuration['development']['database']

    # restore and cleanup
    run_command "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d #{db} ./_backup/backup/export"
    run_command "rm -rf ./_backup"

    Rake::Task["db:migrate"].invoke
  end 

  task :deploy do
    run_command "git push dokku $(git rev-parse --abbrev-ref HEAD):master -f"
    # run_command "flynn run bin/rails db:migrate"
  end

  def run_command(cmd)
    puts "Running: '#{cmd}'"
    puts `#{cmd}`
  end
end