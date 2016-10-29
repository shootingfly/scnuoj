class Admin::StatusesController < Admin::ApplicationController
    def index
        respond_to do |format|
            format.html
            format.json {render json: StatusDatatable.new(view_context)}
        end
    end
end
