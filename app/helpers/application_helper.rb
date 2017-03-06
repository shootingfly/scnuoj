require 'redcarpet'
# require 'coderay'
require 'rouge'
require 'rouge/plugins/redcarpet'
module ApplicationHelper

    # def render_title
    #     # title = @page_title ? "#{t(@page_title)} | #{t('SCNUOJ')}" : "#{t('SCNUOJ')}"
    #     title = @page_title ? "#{@page_title} | SCNUOJ" : "SCNUOJ"
    #     content_tag(:title, title)
    # end

    class HTML < Redcarpet::Render::HTML
        # def block_code(code, language)
        #   CodeRay.scan(code, language).div(:tab_width=>1)
        # end
        include Rouge::Plugins::Redcarpet
    end

    def markdown(text)
        renderer = HTML.new(hard_wrap: true, filter_html: false)
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

    def searchable(array)
        s = array.map{|i| I18n.t(i)}.join(" / ")
        html = "<div id='searchable' value='#{s}'></div>".html_safe
    end

    def table(path, array, width: nil, options: "table table-hover datatable")
        html = ""
        html = <<~END.html_safe
        <table class='#{options}' data-source='#{path}'>
        <thead>
        <tr>
        #{
        if width.nil? then
            array.map{|item|"<th>#{t item}</th>"}.join 
        else
            array.map.with_index{|item, i|"<th width='#{width[i]}%'>#{t item}</th>"}.join
        end
        }
        </tr>
        </thead>
        <tbody></tbody>
        </table>
        END
    end

    def render_breadcrumb
        html = ""
        html = <<~EOF.html_safe
        <ol class="breadcrumb">
        <li> Home</li>
        <li>#{t controller_name}</li>
        <li class="active">#{t action_name}</li>
        #{ if action_name == "index" then
        link_to('new', {controller: controller_name, action: "new"}, class: "btn btn-xs btn-success pull-right")
        else
            link_to(controller_name, {controller: controller_name, action: "index"} , class: "btn btn-xs btn-success pull-right")
        end
        }
        </ol>
        EOF
    end

end
