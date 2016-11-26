#  # Remember close validate on user before db:seed 
# # rake db:seed  or rake db:setup
# 10.times do|index|
#     Manager.create(
#         username: "test#{index}",
#         password: "123456",
#         role: "Admin",
#         remark: Faker::Internet.safe_email
#     )
#     username = Faker::Internet.user_name
#     User.create(
#         student_id: Faker::Number.number(11),
#         username: username,
#         password_digest: "123456",
#         classgrade: "1036",
#         dormitory: "West 2 #{Faker::Number.number(3)}",
#         phone: Faker::PhoneNumber.phone_number,
#         signature: "Hi , I am #{username}",
#         qq: Faker::Number.number(9),
#         rank: 9999,
#         score: Faker::Number.between(0, 1000)
#     )
#     Problem.create(
#         problem_id: Faker::Number.between(1000, 2000),
#         title: Faker::Book.title,
#         ac: 0,
#         submit: 0,
#         grade: index.odd? ? 'S' : 'A',
#         source: index.odd? ? 'ZOJ' : 'POJ' 
#         )
# end
#  