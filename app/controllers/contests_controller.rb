class ContestsController < ApplicationController
	
	before_action :set_contest, except: :index

	layout 'contest', except: :index

	def index
		@page_title = 'Contest'
		respond_to do |format|
			format.html
			format.json {render json: ContestDatatable.new(view_context)}
		end
	end

	def show
		@page_title = @contest.title
	end

	def problem
		@page_title = 'Problem'
		respond_to do |format|
			format.html
			format.json {render json: ContestProblemDatatable.new(view_context, @contest)}
		end
	end

	def status
		@page_title = 'Status'
		respond_to do |format|
			format.html
			format.json {render json: ContestStatusDatatable.new(view_context, @contest)}
		end
	end

	def rank
		@page_title = 'Rank'
		respond_to do |format|
			format.html
			format.json {render json: ContestRankDatatable.new(view_context, @contest)}
		end
	end

	private

	def set_contest
		@contest = Contest.find(params[:id])
	end
	
end