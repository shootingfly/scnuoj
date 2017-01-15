class ContestRankDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= []
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(
      ContestRank.details
    )
  end

  private

  def_delegators :@view, :link_to, :user_path

  def data
    rank = 0
    ('a'..'m').each do |i|
       instance_variable_set("@#{i}", "~~")
    end
    records.map do |record|
      details = record.details
      penalty = "%02d : %02d : %02d"%[record.penalty / 3600, record.penalty % 3600 / 60, record.penalty % 3600 % 60]
      ('a'..'m').to_a[0, details.count].each_with_index do |item, index|
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
        penalty,
        # (1..10).to_a
        ('a'..'m').map do |i|
          instance_variable_get("@#{i}")
        end
        # @a,
        # @b,
        # @c,
        # @d,
        # @e,
        # @f,
        # @g,
        # @h,
        # @i,
        # @j,
        # @k,
        # @l,
        # @m
      ].flatten!
    end
  end

  def get_raw_records
    ContestRank.where(contest_id: params[:id]).order(ac: :desc, penalty: :asc)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
