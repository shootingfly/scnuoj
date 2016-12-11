class Admin::ProblemsController < Admin::ApplicationController
    before_action :set_problem, only: [:show, :edit, :update, :destroy, :chinesizations]

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
        if @problem.save
            flash[:notice] = "Problem #{@problem.title} was created successfully."
            redirect_to new_admin_problem_path
        else
            render :new
        end
    end

    def update
        if @problem.update(problem_params)
            if problem_params[:title] != @problem.title
                @problem.map
            end
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

    def chinesization
        @page_title = 'Chinesization'
    end

    def chinesizations
         @problem.chinesization(params[:title])
         if params[:description]
            File.open("#{Rails.public_path}/uploads/problem/zh/#{@problem.problem_id}.md", "w+") do |f|
                f.write(params[:description].read)
            end
        end
         redirect_to chinesization_admin_problem_path, notice: "Successfully"
    end

    private
    
    def set_problem
        @problem = Problem.find_by(problem_id: params[:id])
    end

    def problem_params
        params.require(:problem).permit(:problem_id, :title, :difficulty, :description, :testdata)
    end

end
