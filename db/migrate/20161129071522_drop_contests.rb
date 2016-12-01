class DropContests < ActiveRecord::Migration
  def change
  	drop_table :contests
  end
end
