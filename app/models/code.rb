class Code < ActiveRecord::Base
	def judge str
    	Resque.enqueue(JudgeJob)
	end
end
