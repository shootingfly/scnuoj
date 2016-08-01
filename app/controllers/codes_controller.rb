class CodesController < ApplicationController
	# protect_from_forgery :except => :create
	def new
		@code = Code.new
	end

	def create
		@code = Code.new(code_params)
		if @code.save
			new_status @code.id
			ProblemJudgeJob.perform_later(@code)
			redirect_to status_path
		else
			render :new
		end
	end

	private
	def code_params
		params.require(:code).permit!#(:username, :problem_id, :code, :language)
	end

	def new_status id
		@status = Status.new
		@status.run_id = id
		@status.username = code_params[:username] 
		@status.problem_id = code_params[:problem_id]
		@status.result = "running"
		@status.time_cost = 0
		@status.space_cost = 0
		@status.language = code_params[:language]
		@status.save
	end
end
