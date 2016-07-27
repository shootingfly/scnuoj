class Problem < ActiveRecord::Base
	mount_uploader :description, ProblemUploader
	mount_uploader :input, InputUploader
	mount_uploader :output, OutputUploader
end
