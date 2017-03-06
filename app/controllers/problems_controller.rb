class ProblemsController < ApplicationController

    before_action :set_problem, only: [:show, :comment, :judge]

    def index
        @page_title = 'Problem'
        respond_to do |format|
            format.html
            format.json { render json: ProblemDatatable.new(view_context) }
        end
    end

    def show
        @page_title = @problem.title
        render 'problem'
    end

    def rand
        problem = Problem.order("RANDOM()").take #rand() in mysql random() in pq
        redirect_to problem_path(problem)
    end

    def prev
        problem = Problem.where("problem_id < ?", params[:id]).order("problem_id DESC").take
        if problem.nil?
            problem = Problem.order("problem_id DESC").take
        end
        redirect_to problem_path(problem)
    end

    def next
        problem = Problem.where("problem_id > ?", params[:id]).order("problem_id ASC").take
        if problem.nil?
            problem = Problem.order("problem_id ASC").take
        end
        redirect_to problem_path(problem)
    end

    def comment
        @page_title = 'Comment'
        @comments = @problem.comments.order("id DESC").page(params[:page]).includes(:user)
        render 'problem'
    end

    def judge
        if current_user
            @page_title = 'Judge'
            @code = Code.new
            render 'problem'
        else
            session[:return_to] = request.fullpath
            redirect_to login_path, notice: "Please Login Before Judge"
        end
    end

    def judge_job
        @code = Code.new(code_params)
        if @code.save
            problem = Problem.find_by(problem_id: params[:id])
            result = JudgeJob.perform_now(@code, problem.time, problem.space)
            redirect_to statuses_path, notice: result
        else
            render :judge
        end
    end

    private

    def set_problem
        @problem = Problem.find_by(problem_id: params[:id])
        @problem_detail = @problem.problem_detail
    end

    def code_params
        params.require(:code).permit!
    end

end
