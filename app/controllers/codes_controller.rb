class CodesController < ApplicationController
	# protect_from_forgery :except => :create
	def new
	end

	def create
		@code = Code.new(code_params)
		if @code.save
			new_status(@code.id)
			ProblemJudgeJob.perform_later(@code)
			redirect_to statuses_path
		else
			render :new
		end
	end

	private
	def code_params
		params.require(:code).permit!
	end

	def new_status id
		@status = Status.new
		@status.run_id = id
		@status.username = User.find_by_student_id(code_params[:student_id]).username 
		@status.problem_id = code_params[:problem_id]
		@status.result = "running"
		@status.time_cost = 0
		@status.space_cost = 0
		@status.language = code_params[:language]
		@status.save
	end

end
