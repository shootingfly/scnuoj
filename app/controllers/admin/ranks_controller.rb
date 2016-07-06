class Admin::RanksController < Admin::ApplicationController
  def index
    @ranks = Rank.all
  end
end
