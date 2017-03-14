class ProblemDetail < ActiveRecord::Base
	belongs_to :problem

	def pass
        	"#{ratio.to_i}% (#{ac}/#{submit})"
    	end

end