class CodesController < ApplicationController
	protect_from_forgery :except => :create
	def new
		@code = Code.new
	end

	def create
		@code = Code.new(code_params)
		if @code.save
			ProblemJudgeJob.perform_later(@code)
			# @code.judge(code_params[:code], 1000) 

			# GuestsCleanupJob.new.perform(@code)
			redirect_to status_path
		else
			render :new
		end
	end

	def code_params
		params.require(:code).permit(:username, :problem_id, :code, :language)
	end
end
