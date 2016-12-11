class ContestProblemDatatable < AjaxDatatablesRails::Base

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

    def data
        records.map do |record|
            is_ac = "Yes"
            [
                is_ac,
                record.problem_id,
                "Hello",
                record.time,
                record.ac,
                record.submit
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
