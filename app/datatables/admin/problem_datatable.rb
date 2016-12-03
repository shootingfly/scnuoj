class Admin::ProblemDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      Problem.problem_id 
      Problem.title 
      Problem.grade
      Problem.ac 
      Problem.submit
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      Problem.problem_id 
      Problem.title
      Problem.grade
    )
  end

  private

  def_delegators :@view, :link_to, :content_tag, :concat, :admin_problem_path, :edit_admin_problem_path
  
  def data
    records.map do |problem|
      [
        problem.problem_id,
        link_to(problem.title, admin_problem_path(problem.problem_id)),
        problem.difficulty,
        problem.problem_detail.ac,
        problem.problem_detail.submit,
        content_tag(:div, "id": problem.problem_id) do
          concat(link_to('查看', admin_problem_path(problem), class: "btn btn-xs btn-info"))
          concat(' ')
          concat(link_to('编辑' , edit_admin_problem_path(problem), class: "btn btn-xs btn-warning"))
          concat(' ')
          concat(link_to('删除', admin_problem_path(problem), method: :delete, remote: true, class: "btn btn-xs btn-danger"))
        end
      ]
    end
  end

  def get_raw_records
    Problem.includes(:problem_detail).all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
