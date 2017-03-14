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

    def_delegators :@view, :current_user, :link_to, :user_path, :error_status_path, :problem_path, :image_tag

    def data
        @current = current_user.try(:username)
        records.map do |status|
            status.result =
                case status.result
                when AC                 then "<label class='text-success'>#{status.result}</label>"
                when CE, RE         then "#{link_to status.result, error_status_path(status.run_id)}"
                when WA                then "<label class='text-danger'>#{status.result}</label>"
                else    "<label class='text-warning'>#{status.result }</label>"
                end
            [
                current?(status.username),
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

    def current?(name)
        if @current == name
            image_tag("Check_mark.png", size: "16")
        else
            ""
        end
    end

    def get_raw_records
        Status.order(id: :desc)
    end

end
