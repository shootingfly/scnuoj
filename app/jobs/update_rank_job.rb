class UpdateRankJob < ActiveJob::Base
  queue_as :default

  def perform
  	ids = UserDetail.order("score DESC").ids
  	count = UserDetail.count
  	attributes = []
  	1.upto(count) do |i|
	  	attributes << {rank: i}
	end
	UserDetail.update(ids, attributes)
  end
end
