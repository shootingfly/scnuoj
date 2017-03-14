class ContestsController < ApplicationController
	
	layout 'contest', except: :index

	before_action :set_contest, except: :index
	before_action :require_login, except: :index

	def index
		@page_title = t 'Contest'
		respond_to do |format|
			format.html
			format.json {render json: ContestDatatable.new(view_context)}
		end
	end

	def problems
		@page_title = t 'Problem'
		respond_to do |format|
			format.html
			format.json {render json: ContestProblemDatatable.new(view_context, @contest)}
		end
	end

	def detail
	end

	def status
		@page_title = t 'Status'
		respond_to do |format|
			format.html
			format.json {render json: ContestStatusDatatable.new(view_context, @contest)}
		end
	end

	def ranks
		@page_title = t 'Rank'
		respond_to do |format|
			format.html
			format.json {render json: ContestRankDatatable.new(view_context, @contest)}
		end
	end

	private

	def set_contest
		@contest = Contest.find(params[:id])
	end

	def require_login
		unless cookies[:token]
			session[:return_to] = request.fullpath
	        	redirect_to(login_path, notice: "请先登录")
	        end
   	end
	
end