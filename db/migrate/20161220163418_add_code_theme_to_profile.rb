class AddCodeThemeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :code_theme, :string
  end
end
