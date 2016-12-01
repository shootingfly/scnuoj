class UpdateStudentId < ActiveRecord::Migration
  def change
  	change_column :users, :student_id, :string
  	change_column :user_logins, :student_id, :string
  	change_column :codes, :student_id, :string
  	change_column :statuses, :student_id, :string
  end
end
