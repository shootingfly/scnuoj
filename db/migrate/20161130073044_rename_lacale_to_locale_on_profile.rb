class RenameLacaleToLocaleOnProfile < ActiveRecord::Migration
  def change
  	rename_column :profiles, :lacale, :locale
  end
end
