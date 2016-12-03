class WeekRankDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Rank.week_rank)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(User.username Rank.week_score)
  end

  private

  def data
    records.map do |record|
      [
        record.user.username,
        record.week_rank,
        record.week_score,
        record.grade_rank,
        record.grade_score
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    Rank.includes(:user).all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
