class RankDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      username
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      username
    )
  end

  private

  def data
    records.map do |rank|
      [
        rank.rank,
        rank.username,
        rank.classgrade,
        rank.dormitory,
        rank.ac,
        rank.submit
      ]
    end
  end

  def get_raw_records
    Rank.all
  end

end
