class RebuildDatabase < ActiveRecord::Migration
  def change
  	# managers
  	rename_column :managers, :password, :password_digest
  	# users
  	remove_columns :users, :password_digest, :auth_token, :score, :rank
  	change_column :users, :student_id, :integer, using: 'student_id::integer'
  	# user_infos
  	create_table :user_logins do |t|
  		t.belongs_to :user
  		t.integer :student_id, unique: true
  		t.string :password_digest
  	end
  	# user_details
  	add_column :user_details, :score, :integer, { default: 0, null: false }
  	add_column :user_details, :rank, :integer, { default: 9999, null: false }
  	# problems
  	change_column :problems, :problem_id, :integer, using: 'problem_id::integer', unique: true
  	remove_columns :problems, :input, :output, :grade, :ac, :submit
  	add_column :problems, :difficulty, :integer, default: 1
  	add_column :problems, :samples, :string
  	# problem_details
  	create_table :problem_details do |t|
  		t.belongs_to :problem
  		t.integer :ac, default: 0, null: false
  		t.integer :submit, default: 0, null: false
  		t.integer :ce, default: 0, null: false
  		t.integer :me, default: 0, null: false
  		t.integer :te, default: 0, null: false
  		t.integer :re, default: 0, null: false
  		t.integer :pe, default: 0, null: false
  		t.integer :wa, default: 0, null: false
  		t.string :last_person
  		t.timestamps null: false
  	end
  	# ranks
  	drop_table :ranks
  	create_table :ranks do |t|
  		t.belongs_to :user
  		t.integer :week_rank, default: 9999, null: false
  		t.integer :week_score, default: 0
  		t.integer :grade_rank, default: 9999, null: false
  		t.integer :grade_score, default: 0
  	end
  	# 

  end
end
