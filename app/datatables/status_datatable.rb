class StatusDatatable < AjaxDatatablesRails::Base

    def sortable_columns
        @sortable_columns ||= %w(
            Status.run_id
        )
    end

    def searchable_columns
        @searchable_columns ||= %w(
            Status.run_id
            Status.username
            Status.problem_id
            Status.result
            Status.language
            Status.created_at
        )
    end

    def_delegators :@view, :current_user, :link_to, :user_path

    def data
        records.map do |status|
            created_at = status.created_at.strftime("%m-%d %H:%M:%S")
            if status.result == "Accepted"
                status.result ="<label class='text-success'>#{status.result }</label>"
            elsif status.result == "Compile Error"
                status.result ="<label class='text-danger'>#{status.result }</label>"
            elsif status.result != "Wrong Answer"
                status.result ="<label class='text-warning'>#{status.result }</label>"
            end
            [
                status.run_id,
                link_to(status.username, user_path(status.student_id) ),
                status.problem_id,
                status.result,
                status.language,
                created_at
            ]
        end
    end

    def get_raw_records
        Status.order(created_at: :desc)
    end

end
