class JudgeRebackJob < ActiveJob::Base
    queue_as :default

    def perform
        update_rank
        update_detail
    end

    def initialize(*options)
      @uid = options[:uid]
      @pid = options[:pid]
      @score = options[:difficulty] * 5
      @problem_id = options[:problem_id]
      @result = options[:result]
      @username = options[:username]
      @studend_id = options[:student_id]
      @lang= options[:lang]
      @code_id = options[:code_id]
    end

    def update_rank
        rank = Rank.find_by(user_id: @user_id)
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
            code_file = "public/users/#{@student_id}/#{problem_id}.md"
            File.open(code_file, "a+") do |f|
            	f.write("\n``` #{@lang}\n")
            	f.write(Code.find(@code_id).code)
            	f.write("```")
            end
            unless @problem_id.in?(user_detail.ac_record)
                user_detail.ac_record << @problem_id
                user_detail.ac += 1
                user.score += difficulty * FACT
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
