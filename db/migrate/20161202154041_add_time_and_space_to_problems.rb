class AddTimeAndSpaceToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :time, :integer
    add_column :problems, :space, :integer
  end
end
