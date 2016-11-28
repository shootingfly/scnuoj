namespace :git do
	desc "push to https://github.com/shootingfly/scnuoj.git"
	task :develop do
		require 'open3'
		puts "To develop branch"
		system "git add -A"
		system "git commit -m #{ARGV}"
		i, o, e, wt = Open3.popen3("git push origin develop:develop")
		i.puts("shootingfly")
		i.close
		o.close
		e.close
	end
end
