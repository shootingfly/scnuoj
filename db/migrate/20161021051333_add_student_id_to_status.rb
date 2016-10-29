class AddStudentIdToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :student_id, :integer
  end
end
