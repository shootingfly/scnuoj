class Status < ActiveRecord::Base
	def full_name
		"#{problem_id} : #{title}"
	end
end
