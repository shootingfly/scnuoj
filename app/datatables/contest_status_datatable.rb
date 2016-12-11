class ContestStatusDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(
        ContestStatus.run_id
    )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(
      ContestStatus.run_id
    )
  end

  private

  def_delegators :@view, :link_to

  def data
    records.map do |record|
      [
        record.run_id,
        record.team_name,
        record.problem_id,
        record.result,
        record.time,
        record.space,
        record.code_length,
        record.created_at
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    options[:contest].contest_statuses
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
