module Admin::ApplicationHelper

	def render_admin_title
		title = @page_title ? "#{@page_title} | SCNUOJ Admin " : "SCNUOJ Admin"
		content_tag(:title, title)
	end

end
