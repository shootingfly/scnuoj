class Admin::ManagerDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      Manager.username
      Manager.role
      Manager.remark
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      Manager.username
    )
  end

  private

  def_delegators :@view, :link_to, :content_tag, :concat, :admin_manager_path, :edit_admin_manager_path

  def data
    records.map do |manager|
      [
        manager.username,
        manager.role,
        manager.remark,
        (content_tag(:div) do
          concat(link_to("查看", admin_manager_path(manager), class: "btn btn-xs btn-info"))
          concat(' ')
          concat(link_to('编辑', edit_admin_manager_path(manager), class: "btn btn-xs btn-warning"))
          concat(' ')
          concat(link_to('删除', admin_manager_path(manager), method: :delete, data: {confirm: "您确定删除管理员#{manager.username}？"}, class: "btn btn-xs btn-danger"))
        end unless manager.super_admin?) || " "
      ]
    end
  end
  
  def get_raw_records
    Manager.all
  end

end
