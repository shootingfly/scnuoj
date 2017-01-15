class Problem < ActiveRecord::Base

    has_many :comments, dependent: :destroy
    has_one :problem_detail, dependent: :destroy

    mount_uploader :description, Problems::DescriptionUploader
    mount_uploader :testdata, Problems::TestdataUploader
    mount_uploader :zh_description, Problems::ZhDescrptionUploader

    def to_param
        "#{problem_id}"
    end

    def problem_title(locale)
        locale == 'zh' && zh_title || title
    end 

    def total_name(locale)
        "#{problem_id}: #{problem_title(locale)}"
    end

    after_create do
        # map()
        ProblemDetail.create({
            problem_id: self.id
        })
    end

    # def map
    #     File.open("#{Rails.root}/config/locales/en.title.yml", "a+") do |f|
    #         f.puts("  '#{self.problem_id}': \"#{self.title}\"")
    #     end
    # end

    # def  chinesization(title)
    #     File.open("#{Rails.root}/config/locales/zh.title.yml", "a+") do |f|
    #         f.puts("  '#{self.problem_id}': \"#{title}\"") unless title.strip.empty?
    #     end
    # end

end
