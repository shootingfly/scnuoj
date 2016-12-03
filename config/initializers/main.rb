Rails.application.configure do
	console do
		require 'pry'
		config.console = Pry
	end

	config.encoding = 'UTF-8'
	config.filter_parameters += [:password]
	config.log_level = :info
	# config.active_record.logger = nil
end