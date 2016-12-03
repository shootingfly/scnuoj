class ContestsController < ApplicationController
	def index
		respond_to do |format|
			format.html
			format.json {render json: ContestDatatable.new(view_context)}
		end
	end

	def show
		@contest = Contest.find(params[:id])
	end

	def problem
		@problems = Contest.contest_problems
	end

	def status
		respond_to do |format|
			format.html
			format.json {render json: ContestStatusDatatable.new(view_context)}
		end
	end

	def rank
		respond_to do |format|
			format.html
			format.json {render json: ContestRanDatatable.new(view_context)}
		end
	end

	private
	def set_contest
		@contest = Contest.find(params[:id])
	end
end