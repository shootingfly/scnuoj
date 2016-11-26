class AddQqToUser < ActiveRecord::Migration
  def change
  	add_column :users, :qq, :string
  end
end
