class AddGradeToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :grade, :string
  end
end
