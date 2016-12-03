class JudgeRebackJob < ActiveJob::Base
    queue_as :default
    # include SuckerPunch::Job

    def perform(options)
      @uid = options[:uid]
      @pid = options[:pid]
      @score = options[:difficulty] * 5
      @problem_id = options[:problem_id]
      @result = options[:result]
      @username = options[:username]
      @student_id = options[:student_id]
      @language= options[:language]
      @code_id = options[:code_id]
        update_rank
        update_details
    end

    def update_rank
        rank = Rank.find_by(user_id: @uid)
        rank.week_score += @score
        rank.grade_score += @score
        rank.save
    end

    def update_details
        user_detail = UserDetail.find_by(user_id: @uid)
        problem_detail = ProblemDetail.find_by(problem_id: @pid)
        case @result
        when AC
            problem_detail.ac += 1
            code_file = "#{USER_PATH}/#{@student_id}/#{@problem_id}.md"
            code = Code.find(@code_id)
            File.open(code_file, "a+") do |f|
              f.write(">  **#{@language}**\n#{code.created_at.strftime("%Y-%m-%d %T")}")
            	f.write("\n\n``` #{@language.downcase}\n\n")
            	f.write(code.code)
            	f.write("\n```\n")
            end
            unless @problem_id.in?(user_detail.ac_record)
                user_detail.ac_record << @problem_id
                user_detail.ac += 1
                user_detail.score += @score
            end
        when WA
            user_detail.wa += 1
            problem_detail.wa += 1
        when PE
            user_detail.pe += 1
            problem_detail.pe += 1
        when RE
            user_detail.re += 1
            problem_detail.re += 1
        when ME
            user_detail.me += 1
            problem_detail.me += 1
        when TE
            user_detail.te += 1
            problem_detail.te += 1
        when OE
            user_detail.oe += 1
            problem_detail.oe += 1
        when CE
            user_detail.ce += 1
            problem_detail.ce += 1
        end
        problem_detail.last_person = @username
        problem_detail.submit += 1
        user_detail.submit += 1
        problem_detail.save
        user_detail.save
    end
end
