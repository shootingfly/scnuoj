# I/O library
require 'open3'
# Calculate time in case timeout
require 'timeout'

class ProblemJudgeJob < ActiveJob::Base

    queue_as :judge

    # Like main function
    def perform code_id, time = 1
        code = Code.find(code_id)
        read_db(code)
        result = execute_judge(time)
        write_db(result, code)
    end

    def read_db code
        # generate source file
        Dir.chdir("#{Rails.public_path}/users/#{code.student_id}")
        system "touch main.c"
        file = File.open("main.c", "w+")
        file.write(code.code)
        file.close
        # generate standard input and output
        problem_id = code.problem_id
        in_file = File.open("#{INPUT_PATH}/#{problem_id}.in")
        out_file = File.open("#{OUTPUT_PATH}/#{problem_id}.out")
        @std_in = in_file.read unless in_file.nil?
        @std_out = out_file.read unless out_file.nil?
        in_file.close
        out_file.close
    end

    def execute_judge time
        # Compile
        @error = ""
        begin
                Timeout::timeout(1) {
                        $stdin, $stdout, $stderr = Open3.popen3("gcc main.c -o main")
                        @error = $stderr.read || ""
                }
        rescue Timeout::Error
                logger.debug("hahaha1")
                return CE
        end
        unless @error.empty?
                 logger.debug("hahaha2")
                return CE
        end
        # begin
        #         # rescue Runtime Error
        #         before = Time.now
        #         later = 0
        #         Timeout::timeout(time) {
        #                 begin
        #                         $stdin, $stdout, $stderr = Open3.popen3("./main")
        #                         $stdin.puts(@std_in)
        #                 rescue RuntimeError
        #                         return RE
        #                 end
        #                 later = Time.now
        #         }
        # rescue Timeout::Error
        #         return TLE  
        # end
        # # Execute
        # # rescue Time Limit Exceeded
        #         # rescue Runtime Error
                set_count
                before = Time.now
                later = 0
                begin
                        $stdin, $stdout, $stderr, wait_thread = Open3.popen3("timeout  1 ./main ")
                        $stdin.puts(@std_in)
                        exit_status = wait_thread.value.exitstatus
                        logger.debug "count: #{@@count} : #{exit_status}"
                        return TLE if exit_status ==  124
                 rescue RuntimeError
                        return RE
                 end
                later = Time.now
                time_cost = later - before
        # # compare with standard output
        @error = $stderr.read
        @output = $stdout.read
        if @output == @std_out
                return AC
        elsif @output.strip == @std_out.strip
                return PE
        else
                return WA
        end
    end

    def write_db(result, code)
        # Update status
        # Update user
        user = User.find_by_student_id(code.student_id)
        @status = Status.new
        @status.run_id = code.id
        @status.problem_id = code.problem_id
        @status.result = result
        @status.time_cost = 0
        @status.space_cost = 0
        @status.language = code.language
        @status.student_id = code.student_id
        @status.username = user.username
        @status.save
        user_detail = user.user_detail
        case result
        when AC
            user_detail.ac += 1
        when WA
            user_detail.wa += 1
        when PE
            user_detail.pe += 1
        when TLE
            user_detail.te += 1
        when CE
            user_detail.ce += 1
        end
        user_detail.submit += 1
        user_detail.save
        system "rm main*"  
    end

    CE = "Compile Error"
    AC = "Accepted"
    PE = "PE"
    WA = "Wrong Answer"
    TLE = "Time Limited Error"
    INPUT_PATH = "#{Rails.public_path}/uploads/problem/input"
    OUTPUT_PATH = "#{Rails.public_path}/uploads/problem/output"

    private
    @@count = 1
    def set_count
        @@count += 1
    end
end
