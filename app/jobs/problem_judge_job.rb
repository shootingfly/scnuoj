# I/O library
require 'open3'
# Calculate time in case timeout
require 'timeout'

class ProblemJudgeJob < ActiveJob::Base
  queue_as :judge

  # Like main function
  def perform code, time = 1000
    read_db(code)
    result = execute_judge(time)
    write_db(result, code)
  end

  def read_db code
    # generate source file
    Dir.chdir("./public/users/#{code.student_id}")
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
        Timeout::timeout(time) {
            $stdin, $stdout, $stderr = Open3.popen3("gcc main.c -o main")
            @error = $stderr.read || ""
        }
    rescue Timeout::Error
        return CE
    end
    unless @error.empty?
        return CE
    end
    # Execute
    # rescue Time Limit Exceeded
    begin
        # rescue Runtime Error
        Timeout::timeout(time) {
            begin
                $stdin, $stdout, $stderr = Open3.popen3("./main")
                $stdin.puts(@std_in)
            rescue RuntimeError
                return RE
            end
        }
    rescue Timeout::Error
        return TLE
    end
    # compare with standard output
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
    status = Status.find_by_run_id(code.id)
    status.result = result
    status.save
    # Update user
    user = User.find_by_student_id(code.student_id)
    user_detail = UserDetail.find_by_student_id(code.student_id)
    case result
    when AC
      user.ac += 1
    when WA
      user_detail.wa += 1
    when PE
      user_detail.pe += 1
    when TLE
      user_detail.tle += 1
    when CE
      user_detail.ce += 1
    end
    user.submit += 1
    user_detail.save
    user.save
    system "rm main*"
  end

  CE = "Compile Error"
  AC = "Accepted"
  PE = "PE"
  WA = "Wrong Answer"
  TLE = "Time Limited Error"
  INPUT_PATH = "#{Rails.public_path}/uploads/problem/input"
  OUTPUT_PATH = "#{Rails.public_path}/uploads/problem/output"
end
