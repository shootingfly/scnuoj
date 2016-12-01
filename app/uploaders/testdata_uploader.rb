# encoding: utf-8

class TestdataUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
        "uploads/problem/testdata"
    end

    def extension_white_list
        "json"
    end

    def filename
        "#{model.problem_id}.json"
    end

end
