class Admin::ContestProblemDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(
      ContestProblem.problem_id
      )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(
      ContestProblem.problem_id
      )
  end

  private

  def_delegators :@view, :link_to, :problem_contest_path, :admin_contest_problem_path, :edit_admin_contest_problem_path, :content_tag, :concat

  def data
    records.map do |record|
      [
        record.problem_id,
        record.title,
        record.time,
        record.space,
        record.ac,
        record.submit,
        content_tag(:div) do
          # binding.pry
          concat(link_to 'show', problem_contest_path(record.contest_id, record.problem_id), class: "btn btn-primary btn-xs", target: "_blank")
          concat(' ')
          concat(link_to 'Edit', edit_admin_contest_problem_path(contest_id: record.contest_id, id: record.problem_id), class: "btn btn-info btn-xs")
          concat(' ')
          concat(link_to 'Delete', admin_contest_problem_path(record.contest_id, record.problem_id), method: :delete,class: "btn btn-danger btn-xs")
        end
      ]
    end
  end

  def get_raw_records
    ContestProblem.where(contest_id: params[:contest_id])
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
