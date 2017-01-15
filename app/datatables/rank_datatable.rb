class RankDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      UserDetail.rank
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      User.username
      User.classgrade
      User.dormitory
    )
  end

  private

  def_delegators :view, :link_to, :user_path

  def data
    records.map do |record|
      [
        record.rank,
        link_to(record.user.username, user_path(record.user)),
        record.user.classgrade,
        record.user.dormitory,
        record.score
      ]
    end
  end

  def get_raw_records
    UserDetail.includes(:user).references(:user).order(:rank)
  end

end
