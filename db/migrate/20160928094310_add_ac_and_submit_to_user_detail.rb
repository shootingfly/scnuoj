class AddAcAndSubmitToUserDetail < ActiveRecord::Migration
  def change
  	add_column :user_details, :ac, :integer, null: false, default: 0
  	add_column :user_details, :submit, :integer, null: false, default: 0
  end
end
