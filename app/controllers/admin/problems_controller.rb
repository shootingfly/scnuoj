class Admin::ProblemsController < Admin::ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def index
    @problems = Problem.all
  end

  def show
  end

  def new
    @problem = Problem.new
  end

  def edit
  end

  def create
    @problem = Problem.new(problem_params)
    if @problem.save
      redirect_to admin_problem_path(@problem), notice: 'problem was successfully created.' 
    else
      render :new
    end
  end

  def update
    if @problem.update(problem_params)
      redirect_to @problem, notice: 'problem was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    @problem.destroy
    redirect_to problems_url, notice: 'problem was successfully destroyed.' 
  end

  private
    def set_problem
      @problem = problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:stu_num, :username, :password, :classgrade, :dormitory, :phone, :signature)
    end
end
