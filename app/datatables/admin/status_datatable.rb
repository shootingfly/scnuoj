class Admin::StatusDatatable < AjaxDatatablesRails::Base

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

    def_delegators :@view,  :link_to, :user_path, :error_status_path, :problem_path, :image_tag

    def data
        records.map do |status|
            if status.result == "Accepted"
                status.result ="<label class='text-success'>#{status.result}</label>"
            elsif status.result == "Compile Error"
                status.result = "#{link_to status.result, error_status_path(status.run_id), target: "_blank"}"
            elsif status.result != "Wrong Answer"
                status.result ="<label class='text-warning'>#{status.result }</label>"
            end
            [
                status.run_id,
                link_to(status.username, user_path(status.student_id),  target: "_blank"),
                link_to(status.full_name, problem_path(status.problem_id), target: "_blank"),
                status.result,
                status.time_cost + " ms",
                status.space_cost + " kb",
                status.language,
                status.created_at.strftime("%m-%d %H:%M:%S")
            ]
        end
    end

    def get_raw_records
        Status.order(id: :desc)
    end

end
