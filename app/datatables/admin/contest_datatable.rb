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

    def_delegators :@view, :link_to, :new_admin_contest_problem_path,:problems_contest_path, :admin_contest_problems_path, :new_admin_contest_problem_path, :content_tag, :concat, :new_admin_contest_path, :edit_admin_contest_path, :admin_contest_path

    def data
        records.map do |record|
            [
               record.id,
                link_to(record.title,admin_contest_problems_path(record)),
                record.start_time.strftime("%Y-%m-%d %T"),
                record.end_time.strftime("%Y-%m-%d %T"),
                record.status,
                record.address,
                record.remark,
                content_tag(:div) do
                    concat(link_to 'add problem', new_admin_contest_problem_path(record), class: "btn btn-info btn-xs")
                    concat(' ')
                    concat(link_to 'show', problems_contest_path(record), class: "btn btn-info btn-xs", target: "_blank")
                    concat(' ')
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
