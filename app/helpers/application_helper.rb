module ApplicationHelper
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
