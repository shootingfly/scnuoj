# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

problems = Array(1000..1100)
problems.each do |i|
  if i.odd?
    grade = "A"
  else
    grade = "S"
  end
  Problem.create(
    problem_id: "#{i}", 
    title: "Problem#{i}", 
    grade: "#{grade}",
    source: "Admin",
    ac: "#{i}", 
    submit: "#{i}"
  )
end




users = Array(1..100)
users.each do |i|
  User.create(    student_id: i,
    username: i,
    password_digest: i,
    classgrade: "1234567",
    dormitory: "1234567",
    phone: 1234567,
    signature: "1234567"
  )
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