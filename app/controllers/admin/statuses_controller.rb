class Admin::StatusesController < Admin::ApplicationController
  def index
    @statuses = Status.all
  end
end
