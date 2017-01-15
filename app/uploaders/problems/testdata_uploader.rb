# encoding: utf-8

class Problems::TestdataUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
        "problems/testdatas"
    end

    def extension_white_list
        %w(json)
    end

    def filename
        "#{model.problem_id}.json"
    end

end
