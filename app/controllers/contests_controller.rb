#=Contest Controller
#can control every actions about contest
#==Contest Problem
#problem A
#problem B
#==Contest Status
#status A
#status B

class ContestsController < ApplicationController
  def index
  	#see you later
  	@contests = Contest.all
  end

  def show
  	@contest = Contest.find(params[:id])
  end
end
