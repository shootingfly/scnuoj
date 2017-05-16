# #  # Remember close validate on user before db:seed 
# # # rake db:seed  or rake db:setup
# 10.times do|index|
#     Manager.create(
#         username: "test#{index}",
#         password: "123456",
#         role: "Admin",
#         remark: Faker::Internet.safe_email
#     )
#     username = Faker::Internet.user_name
#     User.create(
#         student_id: Faker::Number.between(20132100000, 20132100999),
#         username: username,
#         classgrade: "#{Faker::Number.between(13, 17)} Ben #{Faker::Number.between(1,6)}",
#         dormitory: "West 2 #{Faker::Number.number(3)}",
#         phone: Faker::PhoneNumber.phone_number,
#         signature: "Hi , I am #{username}",
#         qq: Faker::Number.number(9),
#     )
#     Problem.create(
#         problem_id: Faker::Number.between(1000, 2000),
#         title: Faker::Book.title,
#         difficulty: index % 6,
#         source: index.odd? ? 'ZOJ' : 'POJ' 
#         )
# end