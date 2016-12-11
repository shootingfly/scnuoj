class ContestProblem < ActiveRecord::Base
	belongs_to :contest
	# mount_uploader :description, ContestProblemUploader
	# mount_uploader :testdata, ContestTestdataUploader

	def to_param
		"#{problem_id}"
	end
	
end