class Problem < ActiveRecord::Base

    has_many :comments, dependent: :destroy

    mount_uploader :description, ProblemUploader
    mount_uploader :input, InputUploader
    mount_uploader :output, OutputUploader

    def to_param
        problem_id
    end

    def total_name
    	"#{problem_id}: #{title}"
    end
end
