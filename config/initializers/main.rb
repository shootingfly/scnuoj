Rails.application.configure do
	console do
		require 'pry'
		config.console = Pry
	end
	config.encoding = 'UTF-8'
end