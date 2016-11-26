class InitDatabase < ActiveRecord::Migration
    def change
        create_table :managers do |t|
            t.string :username
            t.string :password_digest
            t.string :role
            t.string :auth_token
            t.timestamps null: false
        end

        create_table :user do |t|
            t.integer :student_id
            t.string :username
            t.string :classgrade
            t.string :dormitory
            t.string :qq
            t.string :phone
            t.string :signature
            t.string :avatar
            t.timestamps null: false
        end

        create_table :user_info do |t|
            t.belongs_to :user
            t.integer :student_id
            t.string :password_digest
        end

        create_table :user_details do |t|
            t.belongs_to :user
            t.integer :ac, default: 0
            t.integer :submit, default: 0
            t.integer :ce, default: 0
            t.integer :me, default: 0
            t.integer :te, default: 0
            t.integer :re, default: 0
            t.integer :pe, default: 0
            t.integer :oe, default: 0
            t.integer :wa, default: 0
            t.text :ac_records
            t.integer :score
            t.integer :rank
            t.timestamps null: false
        end

        create_table :problems do |t|
            t.integer :problem_id
            t.string :title
            t.string :description
            t.string :io
            t.integer :difficulty
            t.string :source
            t.timestamps null: false
        end

        create_table :problem_details do |t|
            t.belongs_to :problem
            t.integer :ac, default: 0
            t.integer :submit, default: 0
            t.integer :ce, default: 0
            t.integer :me, default: 0
            t.integer :te, default: 0
            t.integer :re, default: 0
            t.integer :pe, default: 0
            t.integer :oe, default: 0
            t.integer :wa, default: 0
            t.string :last_person
            t.timestamps null: false
        end

        create_table :statuses do |t|
            t.belongs_to :user
            t.belongs_to :problem
            t.integer :run_id
            t.string :username
            t.string :title
            t.string :result
            t.integer :time_cost
            t.integer :space_cost
            t.string :mode
            t.timestamps null: false
        end

        create_table :ranks do |t|
            t.belongs_to :user
            t.string :username
            t.integer :week_rank
            t.integer :week_score
            t.integer :grade_rank
            t.integer :grade_score
        end

        create_table :codes do |t|
            t.integer :student_id
            t.integer :problem_id
            t.string :mode
            t.string :code
        end

        create_table :comments do |t|
            t.belongs_to :user
            t.belongs_to :problem
            t.text :content
            t.timestamps null: false
        end

        create_table :profiles do |t|
            t.belongs_to :user
            t.string :theme
            t.string :mode
            t.string :keymap
        end

        create_table :crono_jobs do |t|
            t.string    :job_id, null: false
            t.text      :log
            t.datetime  :last_performed_at
            t.boolean   :healthy
            t.timestamps null: false
        end
        add_index :crono_jobs, [:job_id], unique: true
    end
end
