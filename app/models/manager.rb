class Manager < ActiveRecord::Base
	before_create :generate_token
	has_secure_password
	private

	def generate_token
		begin
			self.auth_token = SecureRandom.urlsafe_base64
		end while Manager.find_by(auth_token: self.auth_token)
	end

end

