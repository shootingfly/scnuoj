namespace :git do
	desc "push to https://github.com/shootingfly/scnuoj.git"
	task :develop do 
		require 'open3'
		puts "To develop branch"
		system "git add -A"
		system "git commit -m #{Time.now.strftime("%T")}"
		Open3.popen2("git push origin develop:develop") do |i, o, wt|
			o.close
			sleep 3
			i.print "shootingfly\n"
		end
	end
end
