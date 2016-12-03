class ChangeAcRecord < ActiveRecord::Migration
  def change
  	remove_column :user_details, :ac_record
  	add_column :user_details, :ac_record, :integer, :length => 2, :default => {}
  end
end
