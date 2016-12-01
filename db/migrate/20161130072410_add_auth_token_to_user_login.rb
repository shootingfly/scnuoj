class AddAuthTokenToUserLogin < ActiveRecord::Migration
  def change
  	add_column :user_logins, :auth_token, :string
  end
end
