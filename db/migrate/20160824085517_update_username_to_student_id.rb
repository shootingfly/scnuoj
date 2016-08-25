class UpdateUsernameToStudentId < ActiveRecord::Migration
  def change
  	add_column :codes, :student_id, :integer
  	remove_column :codes, :username
  end
end
