# encoding: utf-8

class Contests::TestdataUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "contests/#{model.contest_id}/problems/testdatas"
  end

  def extension_white_list
    %w(json)
  end

  def filename
    "#{model.problem_id}.json"
  end
  
end
