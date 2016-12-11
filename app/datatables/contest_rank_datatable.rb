class ContestRankDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= []
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= []
  end

  private

  def data
    records.map do |record|
      [
        record.rank,
        "Hello",
        record.ac,
        record.submit,
        record.details
      ]
    end
  end

  def get_raw_records
    options[:contest].contest_ranks
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
