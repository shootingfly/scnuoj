class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :problem

	paginates_per 10

	def comment_floor
		comment_ids = Comment.where(problem_id: self.problem_id).ids
		comment_ids.index(id) + 1
	end

	# def comment_ids
	# 	Rails.cache.fetch(self.problem_id) do
	# 		Comment.where(problem_id: self.problem_id).ids
	# 	end
	# end

end
