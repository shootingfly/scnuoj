# encoding: utf-8

class UsersUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/excel"
  end

  def extension_white_list
    %w(xls xlsx)
  end


  def filename
    original_filename
  end

end
