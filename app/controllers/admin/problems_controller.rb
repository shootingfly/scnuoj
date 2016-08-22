class Admin::ProblemsController < Admin::ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def index
    # @problems = Problem.all
    respond_to do |format|
      format.html
      format.json {render json: Admin::ProblemDatatable.new(view_context) }
    end
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
    @problem.ac = 0
    @problem.submit = 0
    if @problem.save
      redirect_to new_admin_problem_path, notice: 'problem was successfully created.' 
    else
      render :new
    end
  end

  def update
    if @problem.update(problem_params)
      redirect_to admin_problem_path(@problem), notice: "problem #{@problem.problem_id} was successfully updated." 
    else
      render :edit
    end
  end

  def destroy
    @problem_id = @problem.problem_id
    @problem.destroy
    respond_to do |format|
      format.html {redirect_to admin_problems_path, notice: 'problem was successfully destroyed.'}
      format.js
    end
    # redirect_to admin_problems_path, notice: 'problem was successfully destroyed.' 
  end

  private
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:problem_id, :title, :description, :input, :output)
    end
end
