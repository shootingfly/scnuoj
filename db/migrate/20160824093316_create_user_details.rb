class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.belongs_to :user
      t.text    :ac_record, null: false, default: ""
      t.integer :wa, null: false, default: 0
      t.integer :pe, null: false, default: 0
      t.integer :re, null: false, default: 0
      t.integer :ce, null: false, default: 0
      t.integer :te, null: false, default: 0
      t.integer :me, null: false, default: 0
      t.integer :oe, null: false, default: 0
      t.timestamps null: false
    end
  end
end
