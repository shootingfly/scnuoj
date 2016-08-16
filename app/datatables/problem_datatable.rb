class ProblemDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(problems.problem_id problems.title)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(problems.problem_id problems.title)
  end

  private

  def_delegators :@view, :link_to, :problem_path
  
  def data
    records.map do |record|
      [
        record.problem_id,
        link_to(record.title, problem_path(record.problem_id)),
        record.ac,
        record.submit
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    Problem.all
    # insert query here
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
