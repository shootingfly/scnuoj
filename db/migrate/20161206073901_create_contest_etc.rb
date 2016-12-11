class CreateContestEtc < ActiveRecord::Migration
    def change
    	create_table :teams do |f|
    		f.string :team_id
    		f.string :password_digest
    		f.string :team_name
    		f.string :school
    		f.string :reward_records, array: true
    		f.string :contest_records, array: true
    	end

    	create_table :contests do |f|
    		f.datetime :start_time
    		f.datetime :end_time
    		f.string :status
    		f.string :address
    		f.string :remark
    	end

    	create_table :contest_problems do |f|
    		f.belongs_to :contest
    		f.string :problem_id
    		f.integer :time
    		f.integer :space
    		f.integer :ac
    		f.integer :submit
    		f.string :description
    		f.string :testdata
    	end

    	create_table :contest_statuses do |f|
    		f.belongs_to :contest
    		f.string :problem_id
    		f.string :team_name
    		f.string :result
    		f.integer :time_cost
    		f.integer :space_cost
    		f.integer :code_length
    		f.datetime :created_at, null: false
    	end

    	create_table :contest_ranks do |f|
    		f.belongs_to :contest
    		f.belongs_to :team
    		f.integer :rank
    		f.integer :ac
    		f.integer :submit
    		f.integer :details, array: true
    	end

    end

end
