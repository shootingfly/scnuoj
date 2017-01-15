class ContestProblemDatatable < AjaxDatatablesRails::Base

    def sortable_columns
        @sortable_columns ||= %w(
            ContestProblem.problem_id
        )
    end

    def searchable_columns
        @searchable_columns ||= %w(
            ContestProblem.problem_id
            ContestProblem.title
        )
    end

    private

    def_delegators :@view, :t, :link_to, :contest_problem_path, :current_user, :image_tag

    def data
        @contest_records = current_user.user_detail.contest_records
        @contest_id = params[:id]
        records.map do |record|
            [
                ac?(record.problem_id),
                link_to(record.problem_id, contest_problem_path(record.contest_id, record)),
                link_to(record.title, contest_problem_path(record.contest_id, record)),
                record.ac,
                record.submit
            ]
        end
    end

    def ac?(problem_id)
        problem_id = @contest_id + problem_id
        if @contest_records.include?(problem_id)
            image_tag("Check_mark.png", size: "16")
        else
            ""
        end
    end

    def get_raw_records
        ContestProblem.where(contest_id: params[:id])
    end

end
