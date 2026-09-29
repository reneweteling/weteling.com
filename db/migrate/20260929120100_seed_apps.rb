class SeedApps < ActiveRecord::Migration[8.1]
  IMAGE_DIR = Rails.root.join('db/data/apps')

  APPS = [
    {
      name: 'HeadsUp',
      url: 'https://headsup-app.com',
      platform: 'iOS & Android',
      image: 'headsup.jpg',
      tagline_nl: 'Twaalf groepsapps. Eén lijstje.',
      tagline_en: 'Twelve group chats. One list.',
      description_nl: "HeadsUp leest mee in je groepsapps en zet elke ochtend op een rij wat jij moet doen, meenemen, betalen of regelen. Tussen de 400 duimpjes per week vist hij die ene vraag voor jou eruit, met een datum erbij. Te downloaden in de App Store en Google Play.",
      description_en: "HeadsUp reads along in your group chats and gives you a list every morning of what you need to do, bring, pay or sort out. Out of 400 thumbs-ups a week it fishes out the one question meant for you, with a date attached. Available on the App Store and Google Play.",
    },
    {
      name: 'WijnVinder',
      url: 'https://wijnvinder.nl',
      platform: 'Web app',
      image: 'wijnvinder.jpg',
      tagline_nl: 'Wijnprijzen vergelijken, met een AI-sommelier erbij.',
      tagline_en: 'Compare wine prices, with an AI sommelier on the side.',
      description_nl: "WijnVinder vergelijkt ruim 1.600 wijnen bij Nederlandse wijnwinkels, zodat je nooit te veel betaalt voor je favoriete fles. Vertel Maurice, de AI-sommelier, wat je eet en hij kiest een wijn uit het assortiment. Gratis en zonder account.",
      description_en: "WijnVinder compares more than 1,600 wines across Dutch wine shops, so you never overpay for your favourite bottle. Tell Maurice, the AI sommelier, what you're eating and he picks a wine from the range. Free, no account needed.",
    },
    {
      name: 'FooterManager',
      url: 'https://footermanager.com',
      platform: 'SaaS',
      image: 'footermanager.jpg',
      tagline_nl: 'E-mailhandtekeningen die zichzelf regelen.',
      tagline_en: 'Email footers that manage themselves.',
      description_nl: "Ontwerp één template en rol hem uit over de hele organisatie. Iedereen vult zijn eigen gegevens in en krijgt een handtekening die gewoon klopt met de huisstijl, zonder HTML aan te raken. Een update? Die staat in één keer bij iedereen. Gratis tot 5 gebruikers.",
      description_en: "Design one template and roll it out to the whole organisation. Everyone fills in their own details and gets an on-brand footer without touching HTML. An update reaches everybody at once. Free for up to 5 users.",
    },
    {
      name: 'Loft',
      url: 'https://reneweteling.github.io/loft-app/',
      platform: 'macOS',
      image: 'loft.jpg',
      tagline_nl: 'Sleep een bestand naar je menubalk, krijg een link terug.',
      tagline_en: 'Drag a file to your menu bar, get a link back.',
      description_nl: "Een native macOS-app die bestanden naar S3 uploadt met één sleepbeweging of via rechtsklik in Finder. Kies hoe lang de link leeft: privé, 1 dag, 30 dagen of publiek. Schermopnames worden eerst naar H.265 gecomprimeerd en de link staat daarna direct op je klembord. Werkt met AWS, R2, B2 en MinIO. Gratis en open source.",
      description_en: "A native macOS app that uploads files to S3 with a single drag or a right-click in Finder. Pick how long the link lives: private, 1 day, 30 days or public. Screen recordings get compressed to H.265 first and the link lands on your clipboard. Works with AWS, R2, B2 and MinIO. Free and open source.",
    },
    {
      name: 'fckr',
      url: 'https://reneweteling.github.io/fckr/',
      platform: 'macOS',
      image: 'fckr.jpg',
      tagline_nl: 'Laat de Mac van je collega praten. Vanuit je terminal.',
      tagline_en: "Make your colleagues' Macs talk. From your terminal.",
      description_nl: "Installeer het één keer en iedereen op het netwerk met fckr kan een zin typen die hardop wordt uitgesproken op jouw Mac. Geen server, alles gaat via Bonjour. Er is wel een log, dus je kunt altijd uitzoeken wie het was. Gebouwd puur voor de lol.",
      description_en: "Install it once and anyone on the network running fckr can type a line that gets spoken out loud on your Mac. No server, everything runs over Bonjour. There is a log, so you can always find out who it was. Built purely for fun.",
    },
  ].freeze

  def up
    APPS.each_with_index do |attrs, i|
      app = App.find_or_initialize_by(name: attrs[:name])
      app.assign_attributes(attrs.except(:image).merge(position: i + 1, active: true))
      app.save!
      # CarrierWave stores under the record id, so attach after the first save.
      File.open(IMAGE_DIR.join(attrs[:image])) { |file| app.update!(image: file) }
    end
  end

  def down
    App.where(name: APPS.map { |a| a[:name] }).destroy_all
  end
end
