require 'open3'
require 'fileutils'
class CommonJudgeJob < ActiveJob::Base
    queue_as :default

    def perform(code)
        @user = User.find_by(student_id: code.student_id)
        @problem = Problem.find_by(problem_id: code.problem_id)
        @lang = code.language
        FileUtils.cd(JUDGE_PATH)
        File.write(CODE_FILE(@lang), code.code)
        out, status = Open3.capture2e(BUILD_CMD(@lang))
        if status.successful?
            if SLOW_LANGUAGES.include?(@lang)
                @time =@problem.time * 2
                @space = @problem.time * 2
            else
                @time = @problem.time
                @space = @problem.space
            end
            testdatas = JSON.parse(File.read(@problem.testdata.store_path))
            testdatas.each do |tests|
                @result = run_one(tests)
                break if @result != AC
            end
        else
            File.write("#{ERROR_PATH}/#{code.id}", out)
            @result = CE
        end
        FileUtils.rm(Dir.glob("*ain*"))
        # write_db()
        Status.create({
                        problem_id:  @problem.problem_id,
                        title:  @problem.title,
                        student_id: @user.student_id,
                        username: @user.username,
                        result: @result,
                        time_cost: @time_cost,
                        space_cost: @space_cost,
                        language: @lang
        })
        @score = @problem.difficulty
        rank  = @user.rank #Rank.find_by(user_id: uid)
        rank.week_score += @score
        rank.grade_score += @score
        rank.save
        problem_detail = @problem.problem_detail#ProblemDetail.find_by()
        problem_detail.submit += 1
        problem_detail.last_person = @user.username
        problem_detail.save
        user_detail = @user.user_detail
        user_detail.submit += 1
        if @result ==  AC && user_detail.ac_records.exclude?(@problem_id)
            user_detail.ac_records << @problem_id
            user_detail.score += @score
        end
        user_detail.save
        if @result == AC
            # write_code
            code =<<-END
            > ** #{@lang} ** #{code.created_at.strftime("%Y-%m-%d %T")}
            ``` #{@lang.downcase}
            #{code.code}
            ```
            END
            File.open("md", "a+") { |f| f.write(code) }
        end
    end

    private

    def run_one(tests)
        standard_in, standard_out = tests
        user_out = String.new
        Open3.popen3(EXE_CMD[@lang]) do |stdin, stdout, stderr, wait_thread|
            stdin.puts(standard_in)
            if space_cost > @space
                @result = ME
            elsif wait_thread.value.signaled?
                @result = TE
            elsif stderr.read.present?
                @result = RE
            else
                user_out = stdout.read
            end
        end
        @result ||= compare_output(user_out, standard_out)
    end

    def compare_output(user_out, standard_out)
        if user_out == standard_out
            AC
        elsif user_out.split == standard_out.split
            PE
        elsif user_out.include?(standard_out)
            OE
        end
    end

end
