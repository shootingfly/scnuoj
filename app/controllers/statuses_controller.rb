class StatusesController < ApplicationController
  def index
  	# @statuses = Status.order("run_id DESC").limit(1000)
  	respond_to do |format|
  		format.html
  		format.json {render json: StatusDatatable.new(view_context)}
  	end
  end

end
