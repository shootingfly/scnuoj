class AddGradeToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :grade, :string
  end
end
