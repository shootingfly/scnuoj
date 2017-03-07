class Admin::UserDatatable < AjaxDatatablesRails::Base

  def sortable_columns
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

  def_delegators :@view, :link_to, :user_path, :edit_admin_user_path, :content_tag, :concat

  def data
    records.map do |user|
      [
        user.student_id, 
        user.username, 
        user.classgrade,
        user.dormitory,
        user.phone,
        user.signature,
        content_tag(:div) do
          concat(link_to('查看', user_path(user), class: "btn btn-xs btn-info", target: "_blank"))
          concat(' ')
          concat(link_to('编辑' , edit_admin_user_path(user), class: "btn btn-xs btn-warning")) 
        end
      ]
    end
  end

  def get_raw_records
    User.all
  end

end
