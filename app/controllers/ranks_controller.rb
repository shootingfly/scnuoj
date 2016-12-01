class RanksController < ApplicationController

  def index
  	@page_title = 'rank'
  	respond_to do |format|
  		format.html
  		format.json {render json: RankDatatable.new(view_context)}
  	end
  end
end