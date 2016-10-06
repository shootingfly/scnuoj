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
	  Problem.grade
	)
  end

  private

  def_delegators :@view, :link_to, :problem_path, :current_user, :image_tag
  
  def data
  	binding.pry
  	ac_record =  current_user.user_detail.ac_record if current_user
	records.map do |problem|
	  is_ac = 
	  	if ac_record && ac_record.include?(problem.problem_id)
	  		image_tag("Check_mark.png", size: "16")
	  		# "<i class='glyphicon glyphicon-ok text-success'></i>"
	  	else
	  		" "
	  	end
	  difficulty = 
		if problem.grade == "S"
			"<i class='glyphicon glyphicon-fire text-danger'></i>"
		else
		  	" "
		end
	  [     
	  	is_ac,
		problem.problem_id,
		link_to(problem.title, problem_path(problem.problem_id)),
		difficulty,
		problem.source
	  ]
	end
  end

  def get_raw_records
	Problem.all
  end

end
