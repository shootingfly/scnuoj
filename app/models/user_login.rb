class UserLogin < ActiveRecord::Base
    belongs_to :user
    has_secure_password
    before_create :generate_token

    private

    def generate_token
        loop {
            self.auth_token = SecureRandom.urlsafe_base64
            break unless UserLogin.find_by(auth_token: self.auth_token)
        }
    end
end
