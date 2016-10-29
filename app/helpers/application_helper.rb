module ApplicationHelper

	def render_title
		title = @page ? "#{@page} | SCNUOJ" : "SCNUOJ"
		content_tag(:title, title)
	end

end
