namespace :db do
	desc "Add some data"
	task :datas => :environment do
		# Problem.update_all(time: 1000, space: 10000)
		# UserDetail.update_all(ac_record: [1000,1003])
		# UserDetail.update_all(ac_record: '{}')
		# UserLogin.update_all(password: "123456")
		ProblemDetail.update_all(ac: 0, submit: 0)
	end
end