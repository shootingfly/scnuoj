# encoding: utf-8

class Contests::DescriptionUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
        "contests/#{model.contest_id}/problems/descriptions"
    end

    def extension_white_list
        %w(md)
    end

    def filename
        "#{model.problem_id}.md"
    end

end
