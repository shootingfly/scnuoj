class CreateDatabase < ActiveRecord::Migration
  def change
    create_table :managers do |t|
    	t.string	:username
    	t.string	:password
    	t.string	:role
    	t.string	:remark
    end

    create_table :users do |t|
    	t.string	:student_id
    	t.string	:username
    	t.string	:password
    	t.string	:classgrade
    	t.string	:dormitory
    	t.string	:phone
    	t.string	:signature
    end

    create_table :problems do |t|
    	t.string	:problem_id
    	t.string	:title
    	t.integer	:ac
    	t.integer	:submit
    end

    create_table :statuses do |t|
        t.string    :run_id
        t.string    :username
        t.string    :problem_id
        t.string    :result
        t.string    :time_cost
        t.string    :space_cost
        t.string    :language
        t.string    :language
        t.timestamps  null: false
    end

    create_table :contests do |t|
        t.string    :contest_id
        t.string    :title
        t.string    :remark
        t.datetime  :start_time
        t.datetime  :end_time
        t.integer   :duration
        t.string    :status
        t.string    :is_publish
        t.string    :password
        t.string    :publisher
        t.timestamps null: false
    end

    create_table :ranks do |t|
        t.string    :rank
        t.string    :username
        t.string    :classgrade
        t.string    :dormitory
        t.integer   :ac
        t.integer   :submit
    end




    # create_table :users do |t|
    # 	t.string		:stu_num
    # 	t.string		:username
    # 	t.string		:password
    # 	t.string		:classgrade
    # 	t.string		:dormitory
    # 	t.string		:phone
    # 	t.text			:signature
    # end

    # create_table :problems do |t|
    # 	t.integer		:problem_id
    # 	t.string		:title
    # 	t.string		:source
    # 	t.integer		:time_limit
    # 	t.integer		:memory_limit
    # 	t.integer		:ac 
    # 	t.integer		:submit
    # 	t.float			:ratio
end
end
