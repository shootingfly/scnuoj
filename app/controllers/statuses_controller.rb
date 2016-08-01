class StatusesController < ApplicationController
  def index
  	@statuses = Status.order("run_id DESC").limit(1000)
  end
end
