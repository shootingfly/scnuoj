class RanksController < ApplicationController

  def index
  	@page_title = 'rank'
  	respond_to do |format|
  		format.html
  		format.json {render json: RankDatatable.new(view_context)}
  	end
  end

  def week_rank
  	@page_title = 'week rank'
  	respond_to do |format|
  		format.html
  		format.json {render json: WeekRankDatatable.new(view_context)}
  	end
  end

end