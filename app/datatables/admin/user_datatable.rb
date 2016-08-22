class Admin::UserDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(
      User.student_id 
      User.username 
      User.classgrade
      User.dormitory
      User.phone
      User.signature
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      User.student_id 
      User.username 
      User.classgrade
      User.dormitory
      User.phone
      User.signature
    )
  end

  private

  def_delegators :@view, :link_to, :admin_user_path, :content_tag, :concat

  def data
    records.map do |user|
      [
        user.student_id, 
        user.username, 
        user.classgrade,
        user.dormitory,
        user.phone,
        user.signature,
        content_tag(:div, "id": user.student_id) do
          concat(link_to('', admin_user_path(user), class: "glyphicon glyphicon-edit"))
          concat(" ")
          concat(link_to('', admin_user_path(user), method: :delete, class: "glyphicon glyphicon-trash"))
        end
      ]
    end
  end

  def get_raw_records
    User.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
