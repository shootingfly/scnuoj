class ChangeContestProblem < ActiveRecord::Migration
  def change
  	change_column :contest_problems, :ac, :integer, { default: 0, null: false }
  	change_column :contest_problems, :submit, :integer, { default: 0, null: false }
  	change_column :contest_problems, :time, :integer,  { default: 1000, null: false }
  	change_column :contest_problems, :space, :integer, { default: 1000, null: false }
  end
end
