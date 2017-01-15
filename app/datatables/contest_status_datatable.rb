class ContestStatusDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    @sortable_columns ||= %w(
        ContestStatus.id
    )
  end

  def searchable_columns
    @searchable_columns ||= %w(
      ContestStatus.username
      ContestStatus.problem_id
      ContestStatus.result
    )
  end

  private

  def_delegators :@view, :link_to, :user_path, :contest_problem_path

  def data
    records.map do |record|
      [
        record.id,
        link_to(record.username, user_path(record.student_id), target: "_blank"),
        link_to(record.problem_id, contest_problem_path(record.contest_id, record)),
        record.result,
        record.time_cost,
        record.space_cost,
        record.language,
        record.code_length,
        record.created_at.strftime("%Y-%m-%d %T")
      ]
    end
  end

  def get_raw_records
    ContestStatus.where(contest_id: params[:id]).order("id DESC")
  end

end
