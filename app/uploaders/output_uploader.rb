# encoding: utf-8

class OutputUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
        "uploads/problem/output"
    end

    def filename
        "#{model.problem_id}.out"
    end

end
