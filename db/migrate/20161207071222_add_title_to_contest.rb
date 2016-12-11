class AddTitleToContest < ActiveRecord::Migration
  def change
  	add_column :contests, :title, :string
  end
end
