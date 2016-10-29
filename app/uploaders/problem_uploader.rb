# encoding: utf-8

class ProblemUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
        "uploads/problem/description"
    end

    def extension_white_list
        %w(html)
    end

    def filename
        "#{model.problem_id}-#{model.title}.html"
    end

end
