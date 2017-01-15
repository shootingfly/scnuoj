namespace :db do
    desc "Add some data"
    task :datas => :environment do
        # Problem.update_all(time: 1000, space: 10000)
        # UserDetail.update_all(ac_record: [1000,1003])
        # UserDetail.update_all(ac_record: '{}')
        # UserLogin.update_all(password: "123456")
        # ProblemDetail.update_all(ac: 0, submit: 0)
        # Manager.create({
        # 	username: 'qq790174750',
        # 	password: 'asas123',
        # 	role: 'Super Admin',
        # 	remark: 'Super Admin'
        # })
        11.times do |i|
        	ContestProblem.create({
        		contest_id: 1,
        		problem_id: (i + 65).chr,
        		ac: i % 3,
        		submit: i
        		})
            # ContestRank.create({
            #                      username: "heeh#{i}",
            #                      student_id: "2013210021#{i}",
            #                      ac: i % 5,
            #                      penalty: i % 2,
            #                      contest_id: 1
            # })
        end
    end
end
