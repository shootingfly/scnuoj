class UpdateContestRank < ActiveRecord::Migration
  def change
  	add_column :contest_ranks, :student_id, :string
  	add_column :contest_ranks, :username, :string
  end
end
