class WeekRankDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(Rank.week_rank)
  end

  def searchable_columns
    @searchable_columns ||= %w(User.username)
  end

  private

  def_delegators :view, :link_to, :user_path

  def data
    records.map do |record|
      [
        link_to(record.user.username, user_path(record.user.student_id)),
        record.week_rank,
        record.week_score
      ]
    end
  end

  def get_raw_records
    Rank.includes(:user).all
  end

end
