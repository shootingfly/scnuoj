class UpdateRankJob < ActiveJob::Base
  queue_as :default

  def perform
  	ids = User.order("score DESC").ids
  	count = User.count
  	attributes = []
  	1.upto(count) do |i|
	  	attributes << {rank: i}
	end
	User.update(ids, attributes)
  end
end
