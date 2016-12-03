class UpdateWeekRankJob < ActiveJob::Base
    queue_as :default

    def perform
        if Time.now.sunday? && Time.now.hour == 24
            Rank.update_all(week_score: 0)
        end
        ids = Rank.order("week_score DESC").ids
        count = Rank.count
        attributes = []
        1.upto(count) do |i|
            attributes << {week_rank: i}
        end
        Rank.update(ids, attributes)
    end
end
