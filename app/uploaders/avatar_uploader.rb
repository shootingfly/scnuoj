# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/avatar"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{model.student_id}.jpg"
  end

end
