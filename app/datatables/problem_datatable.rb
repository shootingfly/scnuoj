class ProblemDatatable < AjaxDatatablesRails::Base

  def sortable_columns
	@sortable_columns ||= %w(
	  Problem.problem_id 
	)
  end

  def searchable_columns
	@searchable_columns ||= %w(
	  Problem.problem_id 
	  Problem.title
	  Problem.zh_title
	  Problem.difficulty
	)
  end

  private

  def_delegators :@view, :link_to, :problem_path, :current_user, :image_tag, :t, :current_locale
  
  def data
  	@ac_record =  current_user.user_detail.ac_record if current_user
	records.map do |problem|
	  [     
	  	ac?(problem.problem_id),
		link_to(problem.problem_id, problem_path(problem)),
		link_to(problem.problem_title(current_locale) , problem_path(problem)),
		problem.difficulty,
		problem.problem_detail.pass,
		problem.source
	  ]
	end
  end

  def ac?(problem_id)
  	if @ac_record && @ac_record.include?(problem_id)
  		image_tag("Check_mark.png", size: "16")
  	else
  		""
  	end
  end

  def get_raw_records
	Problem.includes(:problem_detail).order(problem_id: 'asc')
  end

end
