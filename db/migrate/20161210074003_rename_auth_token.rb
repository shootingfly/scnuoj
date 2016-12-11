class RenameAuthToken < ActiveRecord::Migration
  def change
  	rename_column :user_logins, :auth_token, :token
  end
end
