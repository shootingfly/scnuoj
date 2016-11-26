require 'open3'
require 'fileutils'

class JudgeJob < ActiveJob::Base

    queue_as :judge

    def perform
        before_judge
        @result = execute_judge
        after_judge
    end

    def initialize(code)
        @result = ""
        @lang = code.language
        @time_cost = []
        @space_cost = []
        @time = 1
        @space = 32768 
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
        @time_cost = @time_cost.max || @time
        @space_cost = @space_cost.max || @space
        user = User.find_by(student_id: @code.student_id)
        Status.create({
            run_id: @code.id,
            problem_id: @problem_id,
            result: @result,
            language: @lang,
            time_cost: @time_cost * 1000,
            space_cost: @space_cost,
            student_id: user.student_id,
            username: user.username
        })
        user_detail = user.user_detail
        user_detail.submit += 1
        case @result
        when AC
            unless user_detail.ac_record.include?(@problem_id.to_s)
                user_detail.ac_record << @problem_id
                user_detail.ac += 1
                user.score = 5
            end
        when WA
            user_detail.wa += 1
        when PE
            user_detail.pe += 1
        when RE
            user_detail.re += 1
        when ME
            user_detail.me += 1
        when TE
            user_detail.te += 1
        when OE
            user_detail.oe += 1
        when CE
            user_detail.ce += 1
        end
        user.save
        user_detail.save
        FileUtils.rm Dir.glob('*ain*')
    end

    def run_many
        tests = []
        File.open("#{TEST_PATH}/#{@problem_id}.json") do |f|
            tests = JSON.parse(f.read)
        end
        exe_cmd = EXE_CMD[@lang]
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
        File.open("#{ERROR_PATH}/#{@code.id}", "w") { |f| f.puts(out) }
        return status.success?
        # system(build_cmd)
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
    
    private

    CODE_FILE = {
        "C" => "main.c",
        "C++" => "main.cpp",
        "Ruby" => "main.rb",
        "Java" => "Main.java",
        "Perl" => "main.pl",
        "Python" => "main.py"
    }

    SLOW_LANGUAGES = %w(Ruby Perl Java Python)

    BUILD_CMD = {
        "C" => "gcc main.c -o main",
        "C++" => "g++ main.cpp -O2 -Wall -lm --static -DONLINE_JUDGE -o main",
        "Ruby"  => "ruby -c main.rb",
        "Java" =>"javac Main.java",
        "Perl" =>"perl -c main.pl",
        "Python" => 'python2 -m py_compile main.py',
    }

    EXE_CMD = {
        "C" => "./main",
        "C++" => "./main",
        "Ruby" => "ruby main.rb",
        "Java" => "java Main",
        "Perl" => "perl main.pl",
        "Python"=> "python2 main.pyc"
    }

    CE = "Compile Error"
    RE = "Runtime Error"
    TE = "Time Limit Exceeded"
    ME = "Memory Limit Exceeded"
    AC = "Accepted"
    PE = "Presentation Error"
    OE = "Output Limit Exceeded"
    WA = "Wrong Answer"
    ERROR_PATH = "#{Rails.public_path}/errors"
    TEST_PATH = "#{Rails.public_path}/uploads/problem/test"
end