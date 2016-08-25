class User < ActiveRecord::Base
	
	has_one :user_detail, dependent: :destroy

	has_secure_password
	
	before_create {
		generate_token(:auth_token)
		# generate_diretory
		system "public/users/#{self.student_id}"
		# self.create_user_detail
	}

	before_destroy {
		system "rm #{Rails.public_path}/users/#{self.student_id}"
	}



	# validates :student_id, {
	# 	presence: true,
	# 	numericality: { only_integer: true },
	# 	length: { is: 11 }
	# }

	# validates :username, {
	# 	presence: true,
	# 	length: { in: 2..6 }
	# }

	# validates :password, {
	# 	presence: true,
	# 	length: { in: 2..6 }
	# }

	# validates :classgrade, {
	# 	presence: true
	# }

	# validates :dormitory, {
	# 	presence: true
	# }

	# validates :phone, {
	# 	presence: true,
	# 	format: { with: /\A1[3|4|5|8][0-9]\d{4,8}\z/ }
	# }

	# validates :signature, {
	# 	presence: false
	# }

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end
end
