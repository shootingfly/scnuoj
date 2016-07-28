class ProblemJudgeJob < ActiveJob::Base
  queue_as :judge

  def perform(code = nil, time = 1000)
    # Do something later
    sleep 1
    logger.info "shooting start"
    logger.info "current_directory: #{Dir.pwd}"
    # student_id = User.find_by_username("#{code.username}").student_id
    # workspace = "#{ROOT_PATH}/public/users/#{student_id}"
    workspace = "#{ROOT_PATH}/public/users/fei"
    Dir.chdir(workspace)
    system "rm main.*"
    system "touch main.c"
    f = File.open("main.c", "w+")
    f.write(code.code)
    f.close
    status = Timeout::timeout(time) {
    	stdin, stdout, stderr = Open3.popen3("gcc main.c -o main")
    	error = stderr.read || ""
    	if not error.empty?
    		logger.info "problemerro: Compile Error"
    		return CE
    	end
    }
    output = ""
    logger.info "problemerro: Compile Error" if status == false
    standard_input = File.open("#{ROOT_PATH}/#{INPUT_PATH}/1000.in").read
    status = Timeout::timeout(time) {
    	stdin, stdout, stderr = Open3.popen3("./main")
    	stdin.puts(standard_input)
    	error = stderr.read
        output = stdout.read
    }
    standard_output = File.open("#{ROOT_PATH}/#{OUTPUT_PATH}/1000.out").read
    if output == standard_output
    	 logger.info "problemerro: AC"
    	 return AC
    end
	logger.info "problemerro: something"
    logger.info "shooting end"
  end

  private
  CE = "Compile Error"
  AC = "Accepted"
  ROOT_PATH = "/home/rocky/Desktop/rails_workspace/scnuoj/scnuoj"
  INPUT_PATH = "public/uploads/problem/input"
  OUTPUT_PATH = "public/uploads/problem/output"
end
