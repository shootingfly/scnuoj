class StatusesController < ApplicationController
	
  def index
  	@page_title = 'Statuses'
  	respond_to do |format|
  		format.html
  		format.json {render json: StatusDatatable.new(view_context)}
  	end
  end

  def error
  end
  
end
