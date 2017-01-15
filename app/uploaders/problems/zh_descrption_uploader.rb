# encoding: utf-8

class Problems::ZhDescrptionUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
        "problems/zh_descriptions"
    end

    def extension_white_list
        %w(md)
    end

    def filename
        "#{model.problem_id}.md"
    end

end
