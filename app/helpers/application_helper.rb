require 'redcarpet'
# require 'coderay'
require 'rouge'
require 'rouge/plugins/redcarpet'
module ApplicationHelper

    def render_title
        title = @page_title ? "#{@page_title} | SCNUOJ" : "SCNUOJ"
        content_tag(:title, title)
    end

    class HTML < Redcarpet::Render::HTML
        # def block_code(code, language)
        #   CodeRay.scan(code, language).div(:tab_width=>1)
        # end
        include Rouge::Plugins::Redcarpet
    end

    def markdown(text)
        renderer = HTML.new(hard_wrap: true, filter_html: true)
        options = {
            autolink: true,
            no_intra_emphasis: true,
            fenced_code_blocks: true,
            lax_html_blocks: true,
            strikethrough: true,
            superscript: true
        }
        Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end

end
