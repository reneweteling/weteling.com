module ApplicationHelper
  # "jul 2026 – okt 2026", or "jul 2026 – Heden" while the project runs.
  def project_period(project)
    from = l(project.start_date, format: '%b %Y')
    to = project.end_date ? l(project.end_date, format: '%b %Y') : t('site.cv.present-date')
    "#{from} – #{to}"
  end

  def markdown(md)
    return "" if md.nil?
    md_renderer.render(md).html_safe
  end

  private

  def md_renderer
    @_md_renderer ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      strikethrough: true,
      autolink: true,
      tables: true,
    )
  end

end
