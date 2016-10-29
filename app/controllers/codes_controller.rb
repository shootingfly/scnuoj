class CodesController < ApplicationController

	def new
	end

	def create
		@code = Code.new(code_params)
		if @code.save
			ProblemJudgeJob.perform_now(@code.id)
			redirect_to statuses_path
		else
			render :new
		end
	end

	private
	def code_params
		params.require(:code).permit!
	end

end
