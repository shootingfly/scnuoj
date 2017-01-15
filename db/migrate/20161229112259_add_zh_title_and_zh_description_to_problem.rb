class AddZhTitleAndZhDescriptionToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :zh_title, :string
    add_column :problems, :zh_description, :string
  end
end
