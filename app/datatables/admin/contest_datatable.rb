class Admin::ContestDatatable < AjaxDatatablesRails::Base

    def sortable_columns
        @sortable_columns ||= %w(
            Contest.id
        )
    end

    def searchable_columns
        @searchable_columns ||= %w(
            Contest.id
            Contest.title
        )
    end

    private

    def_delegators :@view, :link_to, :content_tag, :concat, :new_admin_contest_path, :edit_admin_contest_path, :admin_contest_path

    def data
        records.map do |record|
            [
               record.id,
                record.title,
                record.start_time,
                record.end_time,
                record.status,
                record.address,
                record.remark,
                content_tag(:div) do
                    concat(link_to 'edit', edit_admin_contest_path(record), class: "btn btn-info btn-xs")
                    concat(' ')
                    concat(link_to 'delete', admin_contest_path(record), method: :delete, confirm: "Are You Sure?", class: "btn btn-danger btn-xs")
                end
            ]
        end
    end

    def get_raw_records
        Contest.all
    end

end
