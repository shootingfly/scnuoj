class ProblemsController < ApplicationController

  def index
  	respond_to do |format|
      format.html
      format.json {render json: ProblemDatatable.new(view_context) }
    end
  end

  def show
  	@problem = Problem.find_by_problem_id(params[:problem_id])
  	puts "--logger: #{@problem}"
  end

end
