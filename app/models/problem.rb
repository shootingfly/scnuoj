class Problem < ActiveRecord::Base

    has_many :comments, dependent: :destroy
    has_one :problem_detail, dependent: :destroy

    mount_uploader :description, Problems::DescriptionUploader
    mount_uploader :testdata, Problems::TestdataUploader
    mount_uploader :zh_description, Problems::ZhDescrptionUploader

    def to_param
        "#{problem_id}"
    end

    def problem_title
       I18n.locale == :zh && zh_title || title
    end 

    def total_name
        "#{problem_id}: #{problem_title}"
    end

    after_create do
        ProblemDetail.create({
            problem_id: self.id
        })
    end

end