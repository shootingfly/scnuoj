class ContestProblem < ActiveRecord::Base
	belongs_to :contest

	mount_uploader :description, Contests::DescriptionUploader
	mount_uploader :testdata, Contests::TestdataUploader

	def to_param
		"#{problem_id}"
	end

	def total_title
		"Problem #{problem_id} : #{title}"
	end
	
end