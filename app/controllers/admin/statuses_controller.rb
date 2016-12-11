class Admin::StatusesController < Admin::ApplicationController
    def index
    	  @page_title = 'Status'
        respond_to do |format|
            format.html
            format.json {render json: StatusDatatable.new(view_context)}
        end
    end
end
