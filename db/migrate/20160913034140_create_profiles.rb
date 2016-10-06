class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.belongs_to :user
      t.string :theme
      t.string :mode
      t.string :keymap
      t.string :lacale

      t.timestamps null: false
    end
  end
end
