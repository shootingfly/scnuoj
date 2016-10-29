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

  def_delegators :@view, :link_to, :admin_user_path, :admin_edit_user_path, :content_tag, :concat

  def data
    records.map do |user|
      [
        user.student_id, 
        user.username, 
        user.classgrade,
        user.dormitory,
        user.phone,
        user.signature,
        content_tag(:div, "id": user.id) do
          concat(link_to('查看', admin_user_path(user.student_id), class: "btn btn-xs btn-info"))
          concat(' ')
          concat(link_to('编辑' , admin_edit_user_path(user.student_id), class: "btn btn-xs btn-warning")) 
          concat(" ")
          concat(link_to('删除', admin_user_path(user.student_id), method: :delete, remote: true, class: "btn btn-danger btn-xs"))
        end
      ]
    end
  end

  def get_raw_records
    User.all
  end

end
