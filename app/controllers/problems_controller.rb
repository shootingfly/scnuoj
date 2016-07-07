class ProblemsController < ApplicationController
	# respond_to :html, :json

  # def index
		# length = params[:length]
		# start = params[:start]
		# # searchValue = params[:search[value]]
		# orderStr = params[:order[0][column]] + " " + params[:order[0][dir]]
		# # @problems = Problem.order("id desc").limit(length).offset(start)
		# @problems = Problem.all.order(orderStr)
		# @problems.each do |item|
		# 	@item_array = []
		# 	@item_array << [item.problem_id,item.title,item.ac,item.submit]
		# end
		# @recordsTotal = Problem.count
		# @recordsFiltered = @item_array.length
		# @draw = params[:draw].to_i
		# json_hash = {}
		# json_hash.store("data",@item_array)
		# json_hash.store("recordsTotal",@recordsTotal)
		# json_hash.store("recordsFiltered",@recordsFiltered)
		# json_hash.store("draw",@draw)
		# respond_to do |format|
		# 	format.html {render 'index'}
		# 	format.json {render json:json_hash}
		# end
  # end
  def index
  	@problems = Problem.all
  end

  def show
  	@problem = Problem.find_by_problem_id(params[:problem_id])
  end
end
