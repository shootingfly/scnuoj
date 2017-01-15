class AddRunIdToContestStatus < ActiveRecord::Migration
  def change
    add_column :contest_statuses, :run_id, :integer
  end
end
