class Admin::ContestProblemsController < Admin::ApplicationController

	before_action :set_contest_problem, only: [:edit, :update, :show, :destroy]
	
	def index
		@page_title = 'Problem'
		respond_to do |format|
			format.html
			format.json {render json: Admin::ContestProblemDatatble.new(view_context)}
		end
	end

	def new
		@page_title = 'New Problem'
		@contest_problem = ContestProblem.new
	end

	def create
		@contest_problem = ContestProblem.new(contest_problem_params)
		if @contest_problem.save
			redirect_to admin_contest_problems_path
		else
			render :new
		end
	end

	def edit
		@page_title = 'Edit Problem'
	end

	def update
		if @contest_problem.update(contest_problem_params)
			redirect_to admin_contest_problems_path
		else
			render :edit
		end
	end

	def destroy
		if @contest_problem.destroy
			flash[:notice] = "Successful"
		else
			flash[:notice] = "Failed"
		end
		redirect_to admin_contest_problems_path
	end

	def show
	end

	private

	def contest_problem_params
		params.require(:contest_problem).permit!
	end

	def set_contest_problem
		@contest_problem = ContestProblem.find_by(problem_id: params[:id], contest_id: params[:contest_id])
	end

end