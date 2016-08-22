class StatusDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      Status.run_id 
      Status.username
      Status.problem_id 
      Status.result 
      Status.time_cost 
      Status.space_cost 
      Status.language 
      Status.created_at 
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      Status.run_id 
      Status.username
      Status.problem_id 
      Status.result 
      Status.time_cost 
      Status.space_cost 
      Status.language 
      Status.created_at
    )
  end

  private

  def data
    records.map do |record|
      [
        record.run_id, 
        record.username,
        record.problem_id,
        record.result,
        record.time_cost, 
        record.space_cost, 
        record.language,
        record.created_at
      ]
    end
  end

  def get_raw_records
    Status.all
  end

end
