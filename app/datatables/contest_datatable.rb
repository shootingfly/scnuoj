class ContestDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      Contest.id
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      Contest.id
    )
  end

  private

  def_delegators :@view, :link_to, :problems_contest_path

  def data
    records.map do |record|
      [
        record.id,
        link_to(record.title, problems_contest_path(record), target: "_blank"),
        record.start_time.strftime("%Y-%m-%d %T"),
        record.end_time.strftime("%Y-%m-%d %T"),
        record.address,
        record.status,
        record.remark
      ]
    end
  end

  def get_raw_records
    Contest.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
