require 'open3'
require 'fileutils'

class ProblemJudgeJob < ActiveJob::Base

    queue_as :judge

    def perform
        before_judge
        @result = execute_judge
        after_judge
    end

    def initialize(code)
      @lang = code.language
      @time = 1
      @space = 32768 
      @code = code
      @problem_id = code.problem_id
      @student_id = code.student_id
      @result = {}
      @build_cmd = BUILD_CMD[code.language]
      @run_cmd = EXE_CMD[code.language]
      @input = ""
      @output = ""
      @user_output = ""
    end

    def execute_judge
        compile_result = system (@build_cmd)
        if compile_result == false
             return CE
        end
        before_time = Time.now
        Open3.popen3("#{@run_cmd}", :rlimit_cpu => @time, :rlimit_rss => @space * 1024) { |stdin,stdout,stderr,wait_thread|
            # File.open("#{Rails.public_path}/memory.txt", "w+") do |f|
            #     f.write (`cat /proc/#{wait_thread.pid}/status | grep VmPeak`)[/\d+/]
            # end
            cur_space_1 = (`cat /proc/#{wait_thread.pid}/status | grep VmPeak`)[/\d+/].to_i
            stdin.puts(@input) rescue Errno::EPIPE
            cur_space_2 = (`cat /proc/#{wait_thread.pid}/status | grep VmPeak`)[/\d+/].to_i
            cur_space= 0 || ((cur_space_1 > cur_space_2) ? cur_space_1 : cur_space_2)
            puts "#{Time.now} cur_space= #{cur_space_1}, #{cur_space_2}"
            puts "wait_thread.value.stopsig : #{wait_thread.value.stopsig}"
            if cur_space > @space
                return ME
            elsif wait_thread.value.signaled?
                return TE
            elsif stderr.read.size > 0
                return RE
            else
                @space = cur_space
                @user_output = stdout.read
            end
        }
        @time = (Time.now - before_time) * 1000
        File.open("#{Rails.public_path}/time.txt", "w+") do |f|
            f.write(@time)
        end
        if @user_output == @output
            return AC
        elsif @user_output.strip == @output.strip
            return PE
        elsif @user_output.include?(@output)
            return OE
        else
            return WA
        end
    end

    def before_judge
        FileUtils.cd("#{Rails.public_path}/users/#{@student_id}")
        FileUtils.touch("#{CODE_FILE[@lang]}")
        code_file = File.open("#{CODE_FILE[@lang]}", "w")
        code_file.write(@code.code)
        code_file.close
        in_file = File.open("#{INPUT_PATH}/#{@problem_id}.in")
        out_file = File.open("#{OUTPUT_PATH}/#{@problem_id}.out")
        @input = in_file.read
        @output = out_file.read
        in_file.close
        out_file.close
        if SLOW_LANGUAGES.include?(@lang)
            @time *= 2
            @memory *= 2
        end
    end

    def after_judge
        user = User.find_by(student_id: @student_id)
        Status.create({
            run_id: @code.id,
            problem_id: @problem_id,
            result: @result,
            language: @lang,
            time_cost: @time,
            space_cost: @space,
            student_id: @student_id,
            username: user.username
        })
        user_detail = user.user_detail
        user_detail.submit += 1
        case @result
        when AC
            user_detail.ac += 1
            unless user_detail.ac_record.include?("#{@problem_id}")
                user_detail.ac_record << "  #{@problem_id}"
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
        user_detail.save
        FileUtils.rm Dir.glob('*ain*')
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

    INPUT_PATH = "#{Rails.public_path}/uploads/problem/input"
    OUTPUT_PATH = "#{Rails.public_path}/uploads/problem/output"
end
