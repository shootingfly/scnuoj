require 'open3'
require 'fileutils'

class JudgeJob < ActiveJob::Base

    queue_as :judge

    def perform
        before_judge
        @result = execute_judge
        after_judge
    end

    def initialize(code, time, space)
        @result = ""
        @lang = code.language
        @time_cost = []
        @space_cost = []
        @time = time
        @space = space 
        @code = code
        @problem_id = code.problem_id
    end

    def before_judge
        FileUtils.cd("#{Rails.public_path}/users/#{@code.student_id}")
        File.open(CODE_FILE[@lang], "w") {|f| f.write(@code.code) }
        if SLOW_LANGUAGES.include?(@lang)
            @time *= 2
            @space *= 2
        end
    end

    def execute_judge
        if compile_successful?
            return run_many
        else
            return CE
        end
    end

    def after_judge
        FileUtils.rm Dir.glob('*ain*')
        @time_cost = @time_cost.max || @time
        @space_cost = @space_cost.max || @space
        ActiveRecord::Base.connection_pool.with_connection do
            user = User.find_by(student_id: @code.student_id)
            problem = Problem.find_by(problem_id: @problem_id)
            Status.create({
                run_id: @code.id,
                problem_id: @problem_id,
                title: problem.title,
                result: @result,
                language: @lang,
                time_cost: (@time_cost * 1000).ceil,
                space_cost: @space_cost / 1024,
                student_id: user.student_id,
                username: user.username
            })
            return options = {
                uid: user.id,
                pid: problem.id,
                result: @result,
                problem_id: @problem_id,
                username: user.username,
                difficulty: problem.difficulty,
                student_id: user.student_id,
                language: @lang,
                code_id: @code.id
            }
        end
    end
    private

    def run_many
        tests = []
        File.open("#{TEST_PATH}/#{@problem_id}.json") do |f|
            tests = JSON.parse(f.read)
        end
        exe_cmd = EXE_CMD[@lang]
        tests.shuffle!
        tests.each do |test|
            result = run_one(test, exe_cmd)
            return result if result != AC
        end
        return AC
    end

    def run_one(test, exe_cmd)
        standard_in = test[0]
        standard_out = test[1]
        result = nil
        user_out = nil
        time_caculator = Time.now
        Open3.popen3(exe_cmd, :rlimit_cpu => @time, :rlimit_rss => @space) { |stdin, stdout, stderr, wait_thread|
            # space_cost = `ps -o rss= #{wait_thread.pid}`.to_f
            space_cost = (`cat /proc/#{wait_thread.pid}/status | grep VmPeak`)[/\d+/].to_i
            stdin.puts(standard_in)
            # space_cost = `ps -o rss= #{wait_thread.pid}`.to_f
            # space_cost = (`cat /proc/#{wait_thread.pid}/status | grep VmPeak`)[/\d+/].to_i
            result =
                if space_cost > @space
                    ME
                elsif wait_thread.value.signaled?
                    TE
                elsif stderr.read.present?
                    RE
                else
                    nil
                end
            @space_cost << space_cost
            break if result
            user_out = stdout.read
        }
        @time_cost << (Time.now - time_caculator)
        return result || compare_output(standard_out, user_out)
    end

    def compile_successful?
        build_cmd = BUILD_CMD[@lang]
        out, status = Open3.capture2e(build_cmd)
        if status.success?
            return true
        else
            File.open("#{ERROR_PATH}/#{@code.id}", "w") { |f| f.puts(out) }
            return false
        end
    end

    def compare_output(user_out, standard_out)
        if user_out == standard_out
            AC
        elsif user_out.strip == standard_out.strip
            PE
        elsif user_out.include?(standard_out)
            OE
        else
            WA
        end
    end

end