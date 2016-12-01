class Problem < ActiveRecord::Base

    has_many :comments, dependent: :destroy
    has_one :problem_detail, dependent: :destroy

    mount_uploader :description, ProblemUploader
    mount_uploader :testdata, TestdataUploader

    def to_param
        "#{problem_id}"
    end

    def total_name
        "#{problem_id}: #{title}"
    end

    after_create {
        ProblemDetail.create({
            problem_id: self.id
        })
    }


end
