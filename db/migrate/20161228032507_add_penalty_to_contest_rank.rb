class AddPenaltyToContestRank < ActiveRecord::Migration
  def change
    add_column :contest_ranks, :penalty, :time, default: "00:00:00"
    change_column :contest_ranks, :ac, :integer, default: 0
    change_column :contest_ranks, :submit, :integer, default: 0
    change_column :contest_ranks, :details, :integer, array: true, default: Array.new(13,[0,0])
  end
end
