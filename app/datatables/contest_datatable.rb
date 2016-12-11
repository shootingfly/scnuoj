class ContestDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(
      Contest.id
    )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(
      Contest.id
    )
  end

  private

  def_delegators :@view, :link_to, :problem_contest_path

  def data
    records.map do |record|
      [
        record.id,
        link_to(record.title, problem_contest_path(record), target: "_blank"),
        record.start_time,
        record.end_time,
        record.address,
        record.status,
        record.remark
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    Contest.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
