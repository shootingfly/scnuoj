namespace :git do
	desc "push to https://github.com/shootingfly/scnuoj.git"
	task :develop do
		puts "To develop branch"
		system "git add -A"
		system "git commit -m #{ENV['args']}"
		Open3.popen3("git push origin develop:develop") do |stdin, stdout, stderr, wt|
			stdin.puts("shootingfly\nasas123\n")
		end
	end
end
