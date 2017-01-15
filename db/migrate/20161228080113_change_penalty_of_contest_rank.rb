class ChangePenaltyOfContestRank < ActiveRecord::Migration
  def change
  	remove_column :contest_ranks, :penalty
  	add_column :contest_ranks, :penalty, :integer, default: 0
  end
end
