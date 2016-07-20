class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
    	t.text	:code
    	t.string	:language
    	t.integer	:problem_id
    	t.string	:username
      t.timestamps null: false
    end
  end
end
