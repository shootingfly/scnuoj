# encoding: utf-8

class UsersUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/excels"
  end

  def extension_white_list
    %w(xls xlsx)
  end


  def filename
    "#{Time.now.to_i} #{original_filename}"
  end

end
