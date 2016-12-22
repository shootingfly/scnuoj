class JudgeRebackJob < ActiveJob::Base
    queue_as :default
    # include SuckerPunch::Job

    def perform(options)
      uid = options[:uid]
      pid = options[:pid]
      cid = options[:cid]
      problem_id = options[:problem_id]
      score = options[:difficulty] * 5
      result = options[:result]
      username = options[:username]
      ActiveRecord::Base.connection_pool.with_connection do
          @rank = Rank.find_by(user_id: uid)
          @user = UserDetail.find_by(user_id: uid)
          @problem = ProblemDetail.find_by(problem_id: pid)
          update_rank(score)
          update_user(result, score, problem_id)
          update_problem(result, username)
          write_code(cid) if result == AC
      end
    end

    def update_rank(score)
        @rank.week_score += score
        @rank.grade_score += score
        @rank.save
    end

    def update_user(result, score, problem_id)
        @user.submit += 1
        eval("@user.#{parse(result)} += 1")
        if result == AC && @user.ac_record.exclude?(problem_id)
            @user.ac_record << problem_id
            @user.score += score
        end
        @user.save
    end

    def update_problem(result, username)
        @problem.submit += 1
        eval("@problem.#{parse(result)} += 1")
        @problem.last_person = username
        @problem.save
    end

    def write_code(cid)
        code = Code.find(cid)
        lang = code.language
        problem_id = code.problem_id
        student_id = code.student_id
        File.open("#{USER_PATH}/#{student_id}/#{problem_id}.md", "a+") do |f|
            f.write(%Q|
             > **#{lang}** #{code.created_at.strftime("%Y-%m-%d %T")}

             ```#{lang.downcase}

             #{code.code}
             ```
             |)
        end
    end

    private

    def parse(result) 
        hash = {
            AC => "ac",
            CE => "ce",
            RE => "re",
            TE => "te",
            ME => "me",
            PE => "pe",
            OE => "oe",
            WA => "wa"
         }
         hash[result]
    end
end