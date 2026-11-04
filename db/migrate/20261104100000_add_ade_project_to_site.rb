class AddAdeProjectToSite < ActiveRecord::Migration[8.1]
  IMAGE = Rails.root.join('db/data/projects/ade.png')

  ABOUT = <<~MD.freeze
    Amsterdam Dance Event is the world's biggest club festival and electronic music conference. Five days in October, events all over the city, and a conference for the music industry during the day. Its website and app guide visitors and industry delegates through the whole programme.
  MD

  ROLE = <<~MD.freeze
    I came in through Bravoure to bring the platform up to date and ship a new AI guide before the 2026 edition.

    First the foundation: I moved the app into a Turborepo, put an end-to-end test suite over every frontend flow, upgraded the dependencies behind it and fixed the deploy pipeline.

    Then the AI ADE Guide: a chat where visitors find their events through widgets the bot picks, like pills, a slider and result cards. The answers come from partner Momants. I designed the contract between the two, built the streaming middleware on AWS Lambda and the partner API, added embeddings for vector search in Elasticsearch, and shipped it on the web, iOS and Android.
  MD

  def up
    project = Project.find_by!(slug: 'ade')
    project.update!(
      title: 'Amsterdam Dance Event',
      subtitle: 'AI guide, app and platform',
      start_date: Date.new(2026, 7, 20),
      end_date: Date.new(2026, 10, 1),
      description_about_the_company: ABOUT,
      description_my_role: ROLE,
      techniques: ['React Native', 'Expo', 'AI', 'AWS Lambda', 'Elasticsearch', 'Craft CMS', 'Laravel', 'Turborepo'],
      site_active: true,
      cv_active: true
    )
    File.open(IMAGE) { |file| project.update!(image: file) }
  end

  def down
    Project.find_by(slug: 'ade')&.update!(site_active: false, cv_active: false)
  end
end
