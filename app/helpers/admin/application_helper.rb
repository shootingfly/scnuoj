module Admin::ApplicationHelper

	def render_admin_title
		title = @page ? "#{@page} | SCNUOJ Admin " : "SCNUOJ Admin"
		content_tag(:title, title)
	end

end
