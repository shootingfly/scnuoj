class RankDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      rank
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      username,
      classgrade,
      dormitory
    )
  end

  private

  def_delegators :view, :link_to, :user_path

  def data
    records.map do |user|
      [
        user.rank,
        link_to(user.username, user_path(user)),
        user.classgrade,
        user.dormitory,
        user.score
      ]
    end
  end

  def get_raw_records
    User.order(:rank)
  end

end
