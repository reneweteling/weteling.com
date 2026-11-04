class SeedTidydriveApp < ActiveRecord::Migration[8.1]
  IMAGE = Rails.root.join('db/data/apps/tidydrive.jpg')

  ATTRS = {
    name: 'TidyDrive',
    url: 'https://reneweteling.github.io/tidydrive/',
    platform: 'macOS',
    tagline_nl: 'Je schijf is vol. Haal hem terug.',
    tagline_en: 'Your disk is full. Take it back.',
    description_nl: "TidyDrive zit in je menubalk, waarschuwt één keer als je schijf 90% vol is en laat zien wat je developer tools hebben laten liggen: Xcode, simulators, node_modules, caches, oude taalversies en Docker per project. Jij kiest wat weg mag. Gratis, getekend en genotariseerd.",
    description_en: "TidyDrive sits in your menu bar, warns you once when your disk hits 90%, and shows what your developer tools left behind: Xcode, simulators, node_modules, caches, old language versions and Docker per project. You pick what goes. Free, signed and notarized.",
  }.freeze

  def up
    app = App.find_or_initialize_by(name: ATTRS[:name])
    app.assign_attributes(ATTRS.merge(active: true))
    app.save!
    # First in the list: the home page shows the first app as a wide featured card.
    app.insert_at(1)
    # CarrierWave stores under the record id, so attach after the first save.
    File.open(IMAGE) { |file| app.update!(image: file) }
  end

  def down
    App.where(name: ATTRS[:name]).destroy_all
  end
end
