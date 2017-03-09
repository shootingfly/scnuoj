require 'open3'
require 'fileutils'

class JudgeJob < ActiveJob::Base

    # Result
    AC = "Accepted"
    CE = "Compile Error"
    RE = "Runtime Error"
    TE = "Time Limit Exceeded"
    ME = "Memory Limit Exceeded"
    PE = "Presentation Error"
    OE = "Output Limit Exceeded"
    WA = "Wrong Answer"
    
    def perform(code, time, space)
        time = 1000
        space = 1000
        lang = code.language
        problem_id = code.problem_id
        FileUtils.cd(JUDGE_PATH)
        File.write(CODE_FILE[lang], code.code)
        factor = SLOWS.include?(lang) ? 2 : 1
        if factor == 2 || compile?(code.id, lang)
            time_limit = time
            space_limit = space
            exe_cmd =  EXE_CMD[lang]
            run_many(problem_id, exe_cmd, time_limit * factor, space_limit * factor) 
        end
        user = User.find_by(student_id: code.student_id)
        problem = Problem.find_by(problem_id: code.problem_id)
        Status.create({
                        run_id: code.id,
                        problem_id: problem_id,
                        title: problem.title,
                        result: @result,
                        language: lang,
                        time_cost: (0 * 1000).ceil,
                        space_cost: 0,
                        student_id: user.student_id,
                        username: user.username
                })
        score = problem.difficulty
        rank  = user.rank
        rank.week_score += score
        rank.save
        problem_detail = problem.problem_detail
        problem_detail.submit += 1
        eval("problem_detail.#{parse(@result)} += 1")
        problem_detail.last_person = user.username
        problem_detail.save
        user_detail = user.user_detail
        user_detail.submit += 1
        eval("user_detail.#{parse(@result)} += 1")
        if @result ==  AC 
            File.write("1.md", <<-END
            > ** #{lang} ** #{code.created_at.strftime("%Y-%m-%d %T")}
            ``` #{lang.downcase}
            #{code.code}
            ```
            END
            )
            unless user_detail.ac_record.include?(code.problem_id)
                user_detail.ac_record << code.problem_id
                user_detail.score += score
            end
        end
        user_detail.save
    end

    def compile?(code_id, lang)
        out, status = Open3.capture2e(BUILD_CMD[lang])
        unless status.success?
            @result = CE
            File.write("#{ERROR_PATH}/#{code_id}", out)
        end
        return status.success?
    end

    def run_many(problem_id, exe_cmd, time_limit, space_limit)
        testdatas = JSON.parse File.read("#{TEST_PATH}/#{problem_id}.json")
        testdatas.each do |testdata|
            standard_in = testdata[0]
            time_before = Time.now
            result = nil
            out = ""
            # @time_cost = []
            Open3.popen3("timeout 1 #{exe_cmd}", :rlimit_cpu => 1) do |i,o,e,wt|
                     i.puts(standard_in) 
                     result =
                    if e.read.present?
                        RE
                    elsif wt.value.signaled?
                        TE
                    elsif (out = o.read).size > 65535
                        OE
                    else
                        nil
                    end
            end
            # @time_cost << Time.now - time_before
            @result = result || compare_output(out, testdata[1])
            break if @result !=  AC
        end
    end

    def compare_output(out, stdout)
        puts "out : #{out} ; stdout : #{stdout}"
        if out == stdout
            AC
        elsif out.gsub(/\s+/, '') == stdout.gsub(/\s+/, '')
            PE
        else
            WA
        end
    end

    HASH = {
        AC => "ac",
        CE => "ce",
        RE => "re",
        TE => "te",
        ME => "me",
        PE => "pe",
        OE => "oe",
        WA => "wa"
    }

    def parse(result) 
        HASH[result]
    end
    
end