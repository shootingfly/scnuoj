# encoding: utf-8

class InputUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
        "uploads/problem/input"
    end

    def filename
        "#{model.problem_id}.in"
    end

end
