class Admin::StatusesController < Admin::ApplicationController
    def index
    	  @page_title = '状态监测'
        respond_to do |format|
            format.html
            format.json {render json: Admin::StatusDatatable.new(view_context)}
        end
    end
end
