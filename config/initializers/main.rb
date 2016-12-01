Rails.application.configure do
	console do
		require 'pry'
		config.console = Pry
	end

	config.encoding = 'UTF-8'
	config.filter_parameters += [:password]
	config.log_level = :info
	config.time_zone = :local
	config.i18n.default_locale = :en
	# config.active_record.logger = nil
	config.active_record.default_timezone = :local
	config.timestamped_migrations = false
end