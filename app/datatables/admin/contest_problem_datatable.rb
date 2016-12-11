class Admin::ContestProblemDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [ContestProblem.problem_id]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [ContestProblem.problem_id]
  end

  private

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
          concat(link_to 'show', admin_contest_problem_path(record), class: "btn btn-primary btn-xs")
          concat(' ')
          concat(link_to 'Edit', edit_admin_contest_problem_path(record), class: "btn btn-info btn-xs")
          concat(' ')
          concat(link_to 'Delete', admin_contest_problem_path(record), class: "btn btn-danger btn-xs")
        end
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    options[:contest].contest_problems
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
