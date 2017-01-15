class UpdateContestStatus < ActiveRecord::Migration
  def change
  	rename_column :contest_statuses, :team_name, :student_id
  	add_column :contest_statuses, :username, :string
  	add_column :contest_statuses, :title, :string
  end
end
