require 'open3'
require 'fileutils'
class ContestJudgeJob < ActiveJob::Base
    queue_as :default

    def perform(code)
        @contest = Contest.find(code.contest_id)
        @user = User.find_by(student_id: code.student_id)
        @problem = ContestProblem.find_by(contest_id: code.contest_id, problem_id: code.problem_id)
        @lang = code.language
        FileUtils.cd(SAFE_PATH)
        File.write(CODE_FILE[@lang], code.code)
        out, status = Open3.capture2e(BUILD_CMD[@lang])
        if status.success?
            if SLOW_LANGUAGES.include?(@lang)
                @time =@problem.time * 2
                @space = @problem.time * 2
            else
                @time = @problem.time
                @space = @problem.space
            end
            @space_cost = []
            @time_cost = []
            testdatas = JSON.parse(File.read(@problem.testdata.store_path))
            testdatas.each do |tests|
                @result = run_one(tests)
                break if @result != AC
            end
        else
            File.write("#{CE_PATH}/#{code.id}", out)
            @result = CE
        end
        FileUtils.rm(Dir.glob("*ain*"))
        # write_db()
        @time_cost = 0
        @space_cost = 0
        case @result
        when TE
            @time_cost = @time
        when ME
            @space_cost = @space
        when CE
            @time_cost = @space_cost = 0 
        end
        ContestStatus.create({
            contest_id: code.contest_id,
            problem_id:  @problem.problem_id,
            title:  @problem.title,
            student_id: @user.student_id,
            username: @user.username,
            result: @result,
            time_cost: @time_cost,
            space_cost: @space_cost,
            language: @lang
        })
        if @result == AC
            @problem.ac += 1
        end
        @problem.submit += 1
        @problem.save
        @rank = ContestRank.find_by(contest_id: code.contest_id, student_id: code.student_id)
        if @rank.nil?
            @rank = ContestRank.new
            @rank.contest_id = code.contest_id
            @rank.username = @user.username
            @rank.student_id = @user.student_id
        end
        @rank.submit += 1
        num = code.problem_id.ord - 65
        if @result == AC
            @rank.ac += 1
            @rank.details[num][0] = (Time.now - @contest.start_time).to_i
            @rank.penalty += (@rank.details[num][0] + @rank.details[num][1] * 1200)
        else
            @rank.details[num][1] += 1
        end
        @rank.save
    end

    private

    def run_one(tests)
        standard_in, standard_out = tests
        user_out = String.new
        before = Time.now
        Open3.popen3(EXE_CMD[@lang]) do |stdin, stdout, stderr, wait_thread|
            space_cost = (`cat /proc/#{wait_thread.pid}/status | grep VmPeak`)[/\d+/].to_i
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
            @space_cost << space_cost
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
