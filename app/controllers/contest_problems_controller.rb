class ContestProblemsController < ApplicationController
	
	layout 'contest'

	before_action :set_problem

	def show
		@page_title = @problem.problem_id
		render "problem"
	end

	def judge
		if current_user
		    @page_title = 'Judge'
		    @code = ContestCode.new
		    render 'problem'
		else
		    session[:return_to] = request.fullpath
		    redirect_to login_path, notice: "Please Login Before Judge"
		end
	end

	def judge_job
		@code = ContestCode.new(code_params)
		@code.contest_id = params[:id]
		if @code.save
		    ContestJudgeJob.perform_now(@code)
		    redirect_to status_contest_path
		else
		    render :judge
		end
	end

	private

	def set_problem
		@contest = Contest.find(params[:contest_id])
		@items = @contest.contest_problems.pluck(:problem_id, :ac)
		@problem = @contest.contest_problems.find_by(problem_id: params[:id])
	end

	def code_params
		params.require(:contest_code).permit!
	end

end
