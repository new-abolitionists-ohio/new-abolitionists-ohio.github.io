=begin
  Jekyll tag to include Markdown text from _includes directory preprocessing with Liquid.
  Usage:
    {% markdown <filename> %}
  Dependency:
    - kramdown
=end
module Jekyll
  class MarkdownTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end
    require "redcarpet"
    def render(context)
      tmpl = File.read File.join Dir.pwd, "_includes", @text
      # site = context.registers[:site]
      # tmpl = (Liquid::Template.parse tmpl).render site.site_payload
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
      html = markdown(tmpl)
    end
  end
end
Liquid::Template.register_tag('markdown', Jekyll::MarkdownTag)
