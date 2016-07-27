require 'open3'
require 'timeout'

class GuestsCleanupJob < ActiveJob::Base
  queue_as 'file_serve'
	build_cmd = {
		"c" => "gcc main.c",
		"cplusplus" => "g++ main.cpp -O2 -Wall -lm --static -DONLINE_JUDGE -o main",
		"ruby" => "reek main.rb"
	}

	post = {
		"c" => "c",
		"cplusplus" => "cpp"
	}
	time = 5
	memory = 5
  def perform
  	logger.debug("#fsdfs")
  	sleep(900*900*900)
	# 进入工作区
	# 	workspace = "#{PROBLEM_PATH}/1001"
	# 	Dir.chdir(workspace)
	# 	# 建立将编译的文件
	# 	system "rm main main.#{post[@code.language]}"
	# 	system "touch main.#{post[@code.language]}"
	# 	# 输入源码
	# 	f = File.open("main.c", "w+")
	# 	f.write(@code.code)
	# 	f.close
	# 	# 编译
	# 	status = Timeout::timeout(time) {
	# 		stdin, stdout, stderr = Open3.popen3("#{build_cmd[@code.language]}")
	# 	}
	# 	# 读取编译错误
	# 	# error = stderr.read
	# 	error = ""
	# 	output = ""
	# 	# logger.debug("14:35 error = #{error}")
	# 	# 编译报错，返回编译错误
	# 	if not error.empty?
	# 		puts "Compile Error"
	# 	end
	# 	# 读取正确的输入
	# 	correct_input = File.open("in.txt").read
	# 	time_before_build = Time.now.usec.to_f
	# 	# 执行
	# 	str = Dir.pwd
	# 	logger.debug("str= #{str}")
	# 	Dir.chdir(workspace)
	# 	status = Timeout::timeout(time) {
	# 		stdin, stdout, stderr = Open3.popen3("./a.out")
	# 		stdin.puts(correct_input) 
	# 		error = stderr.read
	# 		output = stdout.read
	# 	}
	# 	time_after_build = Time.now.usec.to_f
	# 	# 计算运行时间
	# 	time = time_after_build - time_before_build
	# 	# 时间超时，返回编译超时
	# 	# 
	# 	if not error.empty?
	# 		puts "Running Error"
	# 	end
	# 	if time < 1000
	# 		puts "Time Limit Error"
	# 	# 内存超了，返回内存错误
	# 	elsif memory > 20
	# 		puts "Memory Limit Error"
	# 	end
	# 	# 获取输出
	# 	# 比对输出
	# 	correct_output = File.open("out.txt").read
	# 	# 如果输出相同，则AC
	# 	if output == correct_output
	# 		puts "Accepted"
	# 	# 去掉所有的空格，再比对，相同则PE
	# 	elsif output.chomp == correct_output.chomp
	# 		puts "Presentation Error"
	# 	# 长度过长
	# 	elsif output.length > correct_output.length
	# 		puts "Output Limit"
	# 	else 
	# 		puts "Wrong Answer"
	# 	end
	# 	# 删除文件
	# 	system "rm main main.#{post[@code.language]}"
	# end

	# private
	# PROBLEM_PATH = "/home/rocky/Workspace/scnuoj/scnuoj/public/problemset"
 #  end
end
end
