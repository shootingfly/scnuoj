class Admin::ContestsController < Admin::ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]

  def index
    @contests = Contest.all
  end

  def show
  end

  def new
    @contest = Contest.new
  end

  def edit
  end

  def create
    @contest = Contest.new(contest_params)
    if @contest.save
      redirect_to admin_contest_path(@contest), notice: 'contest was successfully created.' 
    else
      render :new
    end
  end

  def update
    if @contest.update(contest_params)
      redirect_to @contest, notice: 'contest was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    @contest.destroy
    redirect_to contests_url, notice: 'contest was successfully destroyed.' 
  end

  private
    def set_contest
      @contest = contest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params.require(:contest).permit(:stu_num, :contestname, :password, :classgrade, :dormitory, :phone, :signature)
    end
end
