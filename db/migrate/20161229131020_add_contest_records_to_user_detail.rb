class AddContestRecordsToUserDetail < ActiveRecord::Migration
  def change
  	add_column :user_details, :contest_records, :string, :array => true, :default => Array.new
  end
end
