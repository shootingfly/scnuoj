class Admin::ProblemsController < Admin::ApplicationController
    before_action :set_problem, only: [:show, :edit, :update, :destroy]

    def index
        respond_to do |format|
            format.html
            format.json {render json: Admin::ProblemDatatable.new(view_context) }
        end
    end

    def show
        @comments = @problem.comments
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
            flash[:notice] = "Problem #{@problem.title} was created successfully."
            redirect_to new_admin_problem_path
        else
            render :new
        end
    end

    def update
        if @problem.update(problem_params)
            flash[:notice] = "problem #{@problem.problem_id} was successfully updated."
            redirect_to admin_problem_path(@problem)
        else
            render :edit
        end
    end

    def destroy
        @problem_id = @problem.problem_id
        @problem.destroy
        respond_to do |format|
            format.js
        end
    end

    private
    
    def set_problem
        @problem = Problem.find_by(problem_id: params[:id])
    end

    def problem_params
        params.require(:problem).permit(:problem_id, :title, :description, :input, :output)
    end

end
