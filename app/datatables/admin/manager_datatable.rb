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
        content_tag(:div) do
          concat(link_to("show", admin_manager_path(manager.id), class: "btn btn-xs btn-info"))
          concat(' ')
          concat(link_to('edit', edit_admin_manager_path(manager.id), class: "btn btn-xs btn-warning"))
          concat(' ')
          concat(link_to('delete', admin_manager_path(manager.id), method: :delete, confirm: "Are you Sure", class: "btn btn-xs btn-danger"))
        end
      ]
    end
  end
  
  def get_raw_records
    Manager.all
  end

end
