class ContestsProblemsController < ApplicationController
	
	def show
		@problem = current_contest.contest_problem.find(params[:problem_id])
	end

	def judge
	end

	def judge_job
	end
end
