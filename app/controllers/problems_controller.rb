class ProblemsController < ApplicationController

  def index
      @page_title = t('problem')
  	respond_to do |format|
        format.html
        format.json {render json: ProblemDatatable.new(view_context, @user) }
      end
  end

  def show
  	@problem = Problem.find_by_problem_id(params[:problem_id])
  	@page_title = @problem.title
  end

end
