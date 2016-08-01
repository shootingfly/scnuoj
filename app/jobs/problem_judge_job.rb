# require './config/compile.rb'
require 'open3'
require 'timeout'

class ProblemJudgeJob < ActiveJob::Base
  queue_as :judge

  def read_db code
    logger.info "Go into the read_db step: \n"
    logger.info "1 . current_directory is #{Dir.pwd}"
    # generate source file
    system "rm main*"
    system "touch main.c"
    file = File.open("main.c", "w+")
    file.write(code.code)
    file.close
    # generate standard input and output
    input_file = File.open("#{ROOT_PATH}/#{INPUT_PATH}/1000.in")
    output_file = File.open("#{ROOT_PATH}/#{OUTPUT_PATH}/1000.out")
    @standard_input = input_file.read if input_file
    @standard_output = output_file.read if output_file
  end

  def execute_judge time
    logger.info "Go into the execute_judge step: \n"
    # compile
    error = ""
    begin
        Timeout::timeout(time) {
            stdin, stdout, stderr = Open3.popen3("gcc main.c -o main")
            error = stderr.read || ""
        }
    rescue Timeout::Error
        return CE
    end
    if not error.empty?
        return CE
    end
    # run
    # rescue Time Limit Exceeded
    begin
        # rescue Runtime Error
        Timeout::timeout(time) {
            begin
                $stdin, $stdout, $stderr = Open3.popen3("./main")
                $stdin.puts(@standard_input)
            rescue RuntimeError
                return RE
            end
        }
    rescue Timeout::Error
        return TLE
    end
    # compare with standard output
    error = $stderr.read
    @output = $stdout.read
    if @output == @standard_output
        return AC
    elsif @output.strip == @standard_output.strip
        return PE
    else
        return WA
    end
  end

  def write_db(result, code)
    status = Status.find_by(run_id: code.id)
    status.result = result
    status.save
    # status.update(result: "CE")
  end

  def perform code = nil, time = 1000
    read_db(code)
    result = execute_judge(time)
    write_db(result,code)
  end


  # def perform(code = nil, time = 1000)
  #   # Do something later
  #   read_db(code)
  #   result = execute_judge()
  #   write_db(result)



  #   sleep 1
  #   logger.info "shooting start"
  #   logger.info "current_directory: #{Dir.pwd}"
  #   # student_id = User.find_by_username("#{code.username}").student_id
  #   # workspace = "#{ROOT_PATH}/public/users/#{student_id}"
  #   workspace = "#{ROOT_PATH}/public/users/fei"
  #   Dir.chdir(workspace)
  #   system "rm main.*"
  #   system "touch main.c"
  #   f = File.open("main.c", "w+")
  #   f.write(code.code)
  #   f.close
  #   status = Timeout::timeout(time) {
  #       stdin, stdout, stderr = Open3.popen3("gcc main.c -o main")
  #       error = stderr.read || ""
  #       if not error.empty?
  #           logger.info "problemerro: Compile Error"
  #           return CE
  #       end
  #   }
  #   output = ""
  #   logger.info "problemerro: Compile Error" if status == false
  #   standard_input = File.open("#{ROOT_PATH}/#{INPUT_PATH}/1000.in").read
  #   status = Timeout::timeout(time) {
  #       stdin, stdout, stderr = Open3.popen3("./main")
  #       stdin.puts(standard_input)
  #       error = stderr.read
  #       output = stdout.read
  #   }
  #   standard_output = File.open("#{ROOT_PATH}/#{OUTPUT_PATH}/1000.out").read
  #   if output == standard_output
  #        logger.info "problemerro: AC"
  #        return AC
  #   end
  #   logger.info "problemerro: something"
  #   logger.info "shooting end"
  # end

  private
  CE = "Compile Error"
  AC = "Accepted"
  PE = "PE"
  WA = "Wrong Answer"
  ROOT_PATH = "/home/rocky/Desktop/rails_workspace/scnuoj/scnuoj"
  INPUT_PATH = "public/uploads/problem/input"
  OUTPUT_PATH = "public/uploads/problem/output"
end
