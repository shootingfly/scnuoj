class AddScoreAndRankToUser < ActiveRecord::Migration
  def change
  	add_column :users, :score, :integer
  	add_column :users, :rank, :integer
  end
end
