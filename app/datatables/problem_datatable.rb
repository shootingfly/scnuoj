class ProblemDatatable < AjaxDatatablesRails::Base

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

  def_delegators :@view, :link_to, :problem_path, :admin_problem_path, :edit_admin_problem_path, :content_tag, :concat
  
  def data
    records.map do |problem|
      problem.grade = 
        case problem.grade
        when "S"
          "<span class='text-danger'>" + problem.grade + "<span>"
        when "A"
          "<span class='text-warning'>" + problem.grade + "<span>"
        end
      [         
        problem.problem_id,
        link_to(problem.title, problem_path(problem.problem_id)),
        problem.grade,
        problem.ac,
        problem.submit
      ]
    end
  end

  def get_raw_records
    Problem.all
  end

end
