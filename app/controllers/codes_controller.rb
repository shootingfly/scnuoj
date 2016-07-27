class CodesController < ApplicationController
	protect_from_forgery :except => :create
	def new
		@code = Code.new
	end

	def create
		@code = Code.new(code_params)
		if @code.save
			@code.judge("I love U")
			# GuestsCleanupJob.new.perform(@code)
			redirect_to :root
		else
			render :new
		end
	end

	def code_params
		params.require(:code).permit(:username, :problem_id, :code, :language)
	end
end
