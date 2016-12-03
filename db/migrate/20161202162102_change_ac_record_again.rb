class ChangeAcRecordAgain < ActiveRecord::Migration
  def change
  	remove_column :user_details, :ac_record
  	add_column :user_details, :ac_record, :integer, array: true, length: 2, default: '{}'
  end
end
