class Admin::ProblemsController < Admin::ApplicationController
    before_action :set_problem, only: [:edit, :update, :destroy, :chinesizations]

    def index
        @page_title = '题目列表'
        respond_to do |format|
            format.html
            format.json {render json: Admin::ProblemDatatable.new(view_context) }
        end
    end

    def new
        @page_title = '添加题目'
        @problem = Problem.new
    end

    def edit
        @page_title = '修改题目'
    end

    def create
        @problem = Problem.new(problem_params)
        if @problem.save
            flash[:notice] = "新增题目#{@problem.title}"
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
            flash[:notice] = "更新题目#{@problem.problem_id}"
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
        @page_title = '题目汉化'
    end

    def chinesizations
         @problem.chinesization(params[:title])
         if params[:description]
            File.open("#{Rails.public_path}/uploads/problem/description/zh/#{@problem.problem_id}.md", "w+") do |f|
                f.write(params[:description].read)
            end
        end
        if params[:description] || params[:title]
            flash[:notice] = "已汉化"
        else
            flash[:notice] = "汉化失败，参数为空"
        end
        redirect_to chinesization_admin_problem_path
    end

    private
    
    def set_problem
        @problem = Problem.find_by(problem_id: params[:id])
    end

    def problem_params
        params.require(:problem).permit(:problem_id, :title, :difficulty, :description, :testdata)
    end

end
