class RanksController < ApplicationController

  def index
  	@page_title = t 'Rank'
  	respond_to do |format|
  		format.html
  		format.json {render json: RankDatatable.new(view_context)}
  	end
  end

  def week
  	@page_title = t 'WeekRank'
  	respond_to do |format|
  		format.html
  		format.json {render json: WeekRankDatatable.new(view_context)}
  	end
  end

end