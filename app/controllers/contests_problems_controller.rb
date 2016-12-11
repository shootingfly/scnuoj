class ContestsProblemsController < ApplicationController
	
	layout 'contest'

	before_action :set_problem

	def show
		@page_title = @problem.problem_id
	end

	def judge
		@page_title = 'Judge'
	end

	def judge_job
	end

	def set_problem
		@problem = ContestProblem.find_by(contest_id: params[:id], problem_id: params[:problem_id])
	end

end
