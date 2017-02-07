class ContestRankDatatable < AjaxDatatablesRails::Base

  def searchable_columns
    @searchable_columns ||= %w(
      ContestRank.details
    )
  end

  private

  def_delegators :@view, :link_to, :user_path

  def data
    rank = 0
    count = ContestProblem.where(contest_id: params[:id]).count
    id = (count + 64).chr
    # ("A".."#{id}").each do |item|
    #    instance_variable_set("@#{item}", "~~")
    # end
    rank = params[:start].to_i
    records.map do |record|
      details = record.details
      ("A".."#{id}").to_a[0, details.count].each_with_index do |item, index|
        sum = details[index][0] + details[index][1] * 20
        if details[index][0] != 0
          result = "<span class='text-primary'>%d</span><br>(%d, %d)"%[sum, details[index][0], details[index][1]]
        else
          result = "--"
        end
        instance_variable_set("@#{item}", result)
      end
      [
        rank += 1,
        link_to(record.username, user_path(record.student_id), target: "_blank"),
        record.ac,
        to_time(record.penalty),
        ("A".."#{id}").map do |i|
          instance_variable_get("@#{i}")
        end
      ].flatten!
    end
  end

  def get_raw_records
    ContestRank.where(contest_id: params[:id]).order(ac: :desc, penalty: :asc)
  end

  def to_time(penalty)
    "%02d : %02d : %02d"%[penalty / 3600, penalty % 3600 / 60, penalty % 3600 % 60]
  end

end
