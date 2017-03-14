require 'open3'
require 'fileutils'
require 'secure'

class JudgeJob < ActiveJob::Base
    def perform(code, time, space)
        lang = code.language
        problem_id = code.problem_id
        student_id = code.student_id
        FileUtils.cd(JUDGE_PATH)
        File.write(CODE_FILE[lang], code.code)
        factor = SLOWS.include?(lang) ? 2 : 1
        if (factor == 2) || compile?(code.id, lang)
            @time_cost = [0]
            @space_cost = [0]
            exe_cmd =  EXE_CMD[lang]
            run_many(code.id, problem_id, exe_cmd, time * factor, space * factor) 
        end
        FileUtils.rm Dir.glob('*ain*')
        user = User.find_by(student_id: student_id)
        problem = Problem.find_by(problem_id: code.problem_id)
        if @result == AC
            @time_cost, @space_cost = (@time_cost.max * 1000).to_i, @space_cost.max
        else
            @time_cost, @space_cost = 0 , 0
        end
        Status.create({
                        run_id: code.id,
                        problem_id: problem_id,
                        title: problem.title,
                        result: @result,
                        language: lang,
                        time_cost: @time_cost,
                        space_cost: @space_cost,
                        student_id: student_id,
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
        problem_detail.ratio = ((problem_detail.ac / problem_detail.submit.to_f) * 100).to_i
        problem_detail.save
        user_detail = user.user_detail
        user_detail.submit += 1
        eval("user_detail.#{parse(@result)} += 1")
        if @result ==  AC 
            File.open("#{Rails.public_path}/users/#{student_id}/#{problem_id}.md", "a+") do |f|
                f.write(<<~EOF
                + #{code.created_at.strftime("%Y-%m-%d %T")} ------------ #{lang}  

                ``` #{lang.downcase}
                #{code.code}
                ```

                EOF
                )
            end
            unless user_detail.ac_record.include?(problem_id)
                user_detail.ac_record << problem_id
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

    def run_many(code_id, problem_id, exe_cmd, time_limit, space_limit)
        testdatas = JSON.parse File.read("#{TEST_PATH}/#{problem_id}.json")
        testdatas.each do |testdata|
            standard_in = testdata[0]
            time_before = Time.now
            result = nil
            out = ""
            time_before = Time.now
            puts "s",Process.getrlimit(:NPROC)
            Open3.popen3("timeout 1 #{exe_cmd}", :pgroup => true, :rlimit_nproc => 416,  :rlimit_cpu => 1) do |i,o,e,wt|
                     i.puts(standard_in) rescue nil
                     result =
                        if e.read.present?
                            File.write("#{ERROR_PATH}/#{code_id}", e.read)
                            RE
                        elsif wt.value.signaled?
                            TE
                        elsif (out = o.read).size > 65535
                            OE
                        else
                            @space_cost << 1000
                            @time_cost << (Time.now - time_before)
                            nil
                        end
            end
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

    def parse(result) 
        return HASH[result]
    end
end