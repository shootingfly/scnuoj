class User < ActiveRecord::Base
    
    has_many :comments, dependent: :destroy
    has_one :user_detail, dependent: :destroy
    has_one :profile, dependent: :destroy

    mount_uploader :avatar, AvatarUploader

    has_secure_password

    def to_param
        student_id
    end

    before_create {
        generate_token
    }

    after_create {
        generate_avatar
        UserDetail.create(user_id: self.id)
        Profile.create({user_id: self.id, theme: THEME, mode: MODE, keymap: KEYMAP})
        system "mkdir public/users/#{self.student_id}"
    }

    before_destroy {
        system "rm -rf public/users/#{self.student_id}"
    }

    # validates :student_id, {
    #     presence: true,
    #     numericality: { only_integer: true },
    #     length: { is: 11 }
    # }

    # validates :username, {
    #     presence: true,
    #     length: { in: 2..6 }
    # }

    # validates :password, {
    #     presence: true,
    #     length: { in: 2..6 }
    # }

    # validates :classgrade, {
    #     presence: true
    # }

    # validates :dormitory, {
    #     presence: true
    # }

    # validates :phone, {
    #     presence: true,
    #     format: { with: /\A1[3|4|5|8][0-9]\d{4,8}\z/ }
    # }

    # validates :signature, {
    #     presence: false
    # }

    private

    THEME = 'cosmo'
    MODE = 'ruby'
    KEYMAP = 'sublime'

    def generate_token
        begin
            self.auth_token = SecureRandom.urlsafe_base64
        end while User.find_by(auth_token: self.auth_token)
    end

    def generate_avatar
        require 'open-uri'
        qq = self.qq
        avatar_url = "http://q4.qlogo.cn/g?b=qq&nk=#{qq}&s=100"
        begin
            qq_avatar = open(avatar_url) do |f|
                f.read
            end
            avatar_file = File.new("public/qq_avatar/#{qq}.jpg", "wb")
            avatar_file.write(qq_avatar)
        rescue => e
            avatar_file = File.open("public/qq_avatar/default.jpg")
        ensure
            self.avatar = avatar_file
            self.save
            avatar_file.close
        end
    end

    # def generate_password(password)
    #     self.password = self.qq
    # end
end
