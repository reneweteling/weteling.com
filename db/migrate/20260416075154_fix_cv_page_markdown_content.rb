class FixCvPageMarkdownContent < ActiveRecord::Migration[8.1]
  def up
    page = Page.find_by(pagetype: :cv)
    return unless page

    # Fix English content: unescape personal info line into a proper markdown list
    if page.content_en.present?
      en = page.content_en
      en.gsub!(/^\\- \\*\\*Name\\*\\*.*Capelle a\/d IJssel, Dutch$/m, <<~MD.strip)
<div class="personal-info"></div>

- **Name** René Weteling
- **Home address** Johannes Geradtsweg 47, 1222PM Hilversum
- **Phone number** [+316 (0) 55 128 199](tel:0031655128199)
- **Portfolio** [www.weteling.com](https://www.weteling.com)
- **E-mail address** [rene@weteling.com](mailto:rene@weteling.com)
- **Date of birth** 04-12-1986
- **Birthplace & nationality** Capelle a/d IJssel, Dutch
      MD
      en.gsub!("\\[\\[projects\\]\\]", "[[projects]]")
      page.content_en = en
    end

    # Fix Dutch content: unescape personal info line into a proper markdown list
    if page.content_nl.present?
      nl = page.content_nl
      nl.gsub!(/^\\- \\*\\*Naam\\*\\*.*Nederlands$/m, <<~MD.strip)
<div class="personal-info"></div>

- **Naam** René Weteling
- **Adres** Johannes Geradtsweg 47, 1222PM Hilversum
- **Telefoonnummer** [+316 (0) 55 128 199](tel:0031655128199)
- **Portfolio** [www.weteling.com](https://www.weteling.com)
- **E-mailadres** [rene@weteling.com](mailto:rene@weteling.com)
- **Geboortedatum** 04-12-1986
- **Geboorteplaats** Capelle a/d IJssel
- **Nationaliteit** Nederlands
      MD
      nl.gsub!("\\[\\[projects\\]\\]", "[[projects]]")
      page.content_nl = nl
    end

    page.save!
  end

  def down
    # Content migration - no automated rollback
  end
end
