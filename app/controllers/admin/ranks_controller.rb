class Admin::RanksController < Admin::ApplicationController
    def index
        respond_to do |format|
            format.html
            format.json {render json: RanksDatatable.new(view_context)}
        end
    end
end
