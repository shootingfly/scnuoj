class ProblemDetail < ActiveRecord::Base
	belongs_to :problem

	def pass
        	"#{pass_ratio} (#{ac}/#{submit})"
    	end

    	def pass_ratio
    		f = submit == 0 ? 0 : ac / submit.to_f
    		"#{(f * 100).to_i} %"
    	end

end