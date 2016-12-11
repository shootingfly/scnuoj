class UserLogin < ActiveRecord::Base
    belongs_to :user
    has_secure_password
    before_create :generate_token

    validates :password, {
        presence: true,
        length: { in: 6..12}
    }
    private

    def generate_token
        loop {
            self.token = SecureRandom.urlsafe_base64
            break unless UserLogin.find_by(token: self.token)
        }
    end
end
