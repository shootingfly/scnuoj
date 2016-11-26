class RanksController < ApplicationController

  def index
  	@page_title = 'rank'
  	@update_time = CronoJob.take.updated_at
  	respond_to do |format|
  		format.html
  		format.json {render json: RankDatatable.new(view_context)}
  	end
  end
end