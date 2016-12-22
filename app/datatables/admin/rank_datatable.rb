class Admin::RankDatatable < AjaxDatatablesRails::Base

    def sortable_columns
        @sortable_columns ||= %w(
            UserDetail.rank
            User.username
            User.classgrade
            User.dormitory
            UserDetail.ac
            UserDetail.submit
        )
    end

    def searchable_columns
        @searchable_columns ||= %w(
            User.username
            User.classgrade
            User.dormitory
            UserDetail.ac
            UserDetail.submit
            UserDetail.score
        )
    end

    private

    def_delegators :view, :link_to, :user_path

    def data
        records.map do |record|
            [
                record.rank,
                link_to(record.user.username, user_path(record.user), target: "_blank"),
                record.user.classgrade,
                record.user.dormitory,
                record.ac,
                record.submit,
                record.score
            ]
        end
    end

    def get_raw_records
        UserDetail.includes(:user).order(:rank)
    end
end
