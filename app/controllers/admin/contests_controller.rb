class Admin::ContestsController < Admin::ApplicationController
	
	before_action :set_contest, only: [:edit, :update, :show, :destroy]

	def index
		respond_to do |format|
			format.html
			format.json {render json: Admin::ContestDatatable.new(view_context)}
		end
	end

	def new
		@contest = Contest.new
	end

	def create
		@contest = Contest.new(contest_params)
		if @contest.save
			redirect_to admin_contests_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @contest.update(contest_params)
			redirect_to admin_contests_path
		else
			render :edit
		end
	end

	def destroy
		@contest.destroy
		redirect_to admin_contests_path
	end

	def show
	end

	private

	def contest_params
		params.require(:contest).permit!
	end

	def set_contest
		@contest = Contest.find(params[:id])
	end

end
