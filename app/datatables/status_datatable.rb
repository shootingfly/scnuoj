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

    def_delegators :@view, :current_user, :link_to, :user_path, :status_error_path, :problem_path

    def data
        records.map do |status|
            if status.result == "Accepted"
                status.result ="<label class='text-success'>#{status.result }</label>"
            elsif status.result == "Compile Error"
                status.result = "#{link_to status.result, status_error_path(status.run_id)}"
            elsif status.result != "Wrong Answer"
                status.result ="<label class='text-warning'>#{status.result }</label>"
            end
            [
                status.run_id,
                link_to(status.username, user_path(status.student_id)),
                link_to(status.full_name, problem_path(status.problem_id)),
                status.result,
                status.time_cost + " ms",
                status.space_cost + " kb",
                status.language,
                status.created_at.strftime("%m-%d %H:%M:%S")
            ]
        end
    end

    def get_raw_records
        Status.order(created_at: :desc)
    end

end
