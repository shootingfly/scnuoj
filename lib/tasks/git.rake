namespace :git do
	desc "push to https://github.com/shootingfly/scnuoj.git"
	task :develop do 
		puts "To develop branch"
		system "git add -A"
		system "git commit -m #{Time.now.strftime("%T")}"
		system "git push origin develop:develop"
	end
end
