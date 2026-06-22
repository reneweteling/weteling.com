class ContactForm
  include ActiveModel::Model
  extend ActiveModel::Translation


  attr_accessor :name, :email, :subject, :message
  validates :email, email: true
  validates_presence_of :name, :email, :subject, :message

  CONSONANTS = "bcdfghjklmnpqrstvwxz".freeze

  # Heuristic spam check for the bots that skip the honeypot and just POST
  # random-looking garbage into the real fields (e.g. subject "cRfFIoqAPqXMNxvqLbMpPJYx").
  # We don't expose this as a validation error: the controller silently
  # discards a hit so the bot gets no signal to tune against.
  def spam?
    gibberish?(name) || gibberish?(subject) || gibberish?(message)
  end

  private

  def gibberish?(text)
    return false if text.blank?

    text.to_s.split(/\s+/).any? { |token| gibberish_token?(token) }
  end

  # A token is gibberish when it mashes upper/lowercase mid-word, piles up
  # consonants, or has almost no vowels. Real words and names trip none of
  # these: case only switches at word starts and vowels break up the runs.
  def gibberish_token?(token)
    letters = token.scan(/[a-zA-Z]/)
    return false if letters.length < 8

    case_switches = letters.each_cons(2).count { |a, b| upper?(a) != upper?(b) }
    return true if case_switches >= 5

    # Consonant pile-up alone isn't enough: Dutch stacks consonants too
    # (angstschreeuw). Only flag when it's also starved of vowels, which random
    # keyboard mashing is and real words aren't.
    longest_consonant_run = token.downcase.scan(/[#{CONSONANTS}]+/).map(&:length).max.to_i
    vowel_ratio = letters.count { |c| c =~ /[aeiou]/i }.to_f / letters.length
    longest_consonant_run >= 7 && vowel_ratio < 0.30
  end

  def upper?(char)
    char =~ /[A-Z]/ ? true : false
  end
end
