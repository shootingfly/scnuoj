class AddRatioToProblemDetails < ActiveRecord::Migration
  def change
    add_column :problem_details, :ratio, :float
  end
end
