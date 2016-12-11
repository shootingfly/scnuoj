class Admin::RanksController < Admin::ApplicationController
    def index
    	@page_title = 'Rank'
        respond_to do |format|
            format.html
            format.json {render json: Admin::RankDatatable.new(view_context)}
        end
    end
end
