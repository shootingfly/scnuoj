class StatusDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
      Status.run_id 
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      Status.run_id 
      Status.username
      Status.problem_id 
      Status.result 
      Status.language 
      Status.created_at
    )
  end

  def_delegators :@view, :current_user

  def data
    records.map do |record|
      is_yours = 
        if current_user.username == record.username
            if record.result == "Accepted"
              "true"
            else
              "sorry"
             end
        else
            " "
        end
      created_at = record.created_at.strftime("%m/%d %H:%M:%S")
      [
        is_yours,
        record.run_id, 
        record.username,
        record.problem_id,
        record.result,
        record.language,
        created_at
      ]
    end
  end

  def get_raw_records
    Status.order(created_at: :desc)
  end

end
