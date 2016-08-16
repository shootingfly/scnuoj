class UserDatatable < AjaxDatatablesRails::Base

  include AjaxDatatablesRails::Extensions::Kaminari
  def sortable_columns
    @sortable_columns ||= ['User.student_id', 'User.username']
  end

  def searchable_columns
    @searchable_columns ||= ['User.student_id']
  end

  private

  def data
    records.map do |record|
      [
        record.student_id,
        record.username
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    User.all 
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
