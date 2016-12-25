class Admin::RanksController < Admin::ApplicationController
    def index
    	@page_title = '个人排名'
        respond_to do |format|
            format.html
            format.json {render json: Admin::RankDatatable.new(view_context)}
        end
    end
end
