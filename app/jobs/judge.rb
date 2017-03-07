class JudgeJob < ActiveJob::Base

    def perform(code)
        @code = code
        prepare_judge
        execute_judge
        after_judge
    end

    private

    def prepare_judge
        @user = User.find_by(student_id: @code.student_id)
        @problem = Problem.find_by(problem_id: @code.problem_id)
        @lang = code.language
        FileUtils.cd(JUDGE_PATH)
        File.write(CODE_FILE(@lang), @code.code)
    end

    def execute_judge
        if compile_successful?
            return run_many
        else
            return CE
        end
    end

    def create_status()
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
    end

    def update_rank(score)
        rank  = @user.rank
        rank.week_score += score
        rank.grade_score += score
        rank.save
    end

    def update_problem_detail
        problem_detail = @problem.problem_detail
        problem_detail.submit += 1
        eval("problem_detail.#{parse(@result)} += 1")
        problem_detail.last_person = @user.username
        problem_detail.save
    end

    def update_user_detail(score)
        user_detail = @user.user_detail
        user_detail.submit += 1
        eval("user_detail.#{parse(@result)} += 1")
        if @result ==  AC && user_detail.ac_records.exclude?(@problem_id)
            user_detail.ac_records << @problem_id
            user_detail.score += score
        end
        user_detail.save
    end

    def write_code
        if @result == AC
            # write_code
            code =<<-END
            > ** #{@lang} ** #{@code.created_at.strftime("%Y-%m-%d %T")}
            ``` #{@lang.downcase}
            #{@code.code}
            ```
            END
            File.open("md", "a+") { |f| f.write(code) }
        end
    end

    def after_judge
        FileUtils.rm(Dir.glob("*ain*"))
        score = @problem.difficulty
        create_status
        update_rank(score)
        update_problem_detail
        update_user_detail
        write_code
    end

    def compile_successful?
        out, status = Open3.capture2e(BUILD_CMD(@lang))
        File.write("#{ERROR_PATH}/#{@code.id}", out) unless status.success?
        return status.success?
    end

    def run_many
        testdatas = JSON.parse(File.read(@problem.testdata.store_path))
        testdatas.each do |tests|
            @result = run_one(tests)
            break if @result != AC
        end
    end

    def run_one(tests)
        standard_in, standard_out = tests[0], tests[1]
        user_out = String.new
        Open3.popen3(EXE_CMD[@lang]) do |stdin, stdout, stderr, wait_thread|
            stdin.puts(standard_in)
            case
            when space_cost > @space
                return ME
            when wait_thread.value.signaled?
                return TE
            when stderr.read.present?
                return RE
            else
                user_out = stdout.read
            end
        end
        return compare_output(user_out, standard_out)
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