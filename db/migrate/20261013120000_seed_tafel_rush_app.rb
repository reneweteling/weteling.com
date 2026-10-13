class SeedTafelRushApp < ActiveRecord::Migration[8.1]
  IMAGE = Rails.root.join('db/data/apps/tafelrush.jpg')

  ATTRS = {
    name: 'Tafel Rush',
    url: 'https://www.tafelrush.nl/',
    platform: 'iOS & Android',
    tagline_nl: 'Tafels oefenen door ze hardop te zeggen.',
    tagline_en: 'Practise times tables by saying them out loud.',
    description_nl: "De app zegt de som, jij zegt het antwoord. Niks tikken. Snel goed levert XP en combo's op, elke som van 1×1 tot 10×10 heeft een eigen rank en zwakke sommen komen terug als bosses. Daag een vriend uit met precies dezelfde 10 sommen. Gratis, geen account en geen reclame.",
    description_en: "The app reads out the sum, you say the answer. No tapping. Fast correct answers earn XP and combos, every sum from 1×1 to 10×10 has its own rank, and weak ones come back as bosses. Challenge a friend with the exact same 10 sums. Free, no account and no ads.",
  }.freeze

  def up
    app = App.find_or_initialize_by(name: ATTRS[:name])
    app.assign_attributes(ATTRS.merge(active: true))
    app.position = (App.maximum(:position) || 0) + 1 if app.new_record?
    app.save!
    # CarrierWave stores under the record id, so attach after the first save.
    File.open(IMAGE) { |file| app.update!(image: file) }
  end

  def down
    App.where(name: ATTRS[:name]).destroy_all
  end
end
