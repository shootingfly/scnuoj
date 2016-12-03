class UpdateGradeRankJob < ActiveJob::Base
  queue_as :default

  def perform
  	ids = Rank.order("grade_score DESC").ids
  	count = Rank.count
  	attributes = []
  	1.upto(count) do |i|
  		attributes << {grade_rank: i}
  	end
  	Rank.update(ids, attributes)
  end
end
