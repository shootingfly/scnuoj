class CreateContestCodes < ActiveRecord::Migration
  def change
    create_table :contest_codes do |t|
    	t.belongs_to :contest
    	t.text :code
    	t.string :language
    	t.string :problem_id
    	t.string :student_id
    	t.timestamp null: false
    end
  end
end
