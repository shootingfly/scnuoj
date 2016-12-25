module Admin::ApplicationHelper

	def render_admin_title
		title = @page_title ? "#{@page_title} | SCNUOJ 后台管理系统 " : "SCNUOJ 后台管理系统"
		content_tag(:title, title)
	end

end
