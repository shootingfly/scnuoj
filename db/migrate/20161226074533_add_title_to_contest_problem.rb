class AddTitleToContestProblem < ActiveRecord::Migration
  def change
    add_column :contest_problems, :title, :string
  end
end
