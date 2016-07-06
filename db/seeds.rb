# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
items = Array(2..100)
items.each do |i|
	Problem.create(problem_id: "#{i}", title:"sadsa#{i}", ac: "#{i}", submit: "#{i}")
end
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10},
# {problem_id:'1', title:"sadsa", ac: 1, submit: 10}]
# )