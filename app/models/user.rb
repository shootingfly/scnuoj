class User < ActiveRecord::Base

    has_one :user_login, dependent: :destroy
    has_one :user_detail, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_many :comments, dependent: :destroy

    mount_uploader :avatar, AvatarUploader

    def to_param
        student_id
    end

    before_create {
        # generate_token
        generate_avatar
    }

    after_create {
        UserLogin.create({
            user_id: self.id,
            student_id: self.student_id,
            password: self.student_id
        })
        UserDetail.create({
            user_id: self.id
        })
        Profile.create({
            user_id: self.id,
            theme: DEFAULT_THEME,
            mode: DEFAULT_MODE,
            keymap: DEFAULT_KEYMAP,
            locale: DEFAULT_LOCALE
        })
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

    def generate_avatar
        require 'open-uri'
        avatar_url = "http://q4.qlogo.cn/g?b=qq&nk=#{self.qq}&s=100"
        begin
            qq_avatar = open(avatar_url) do |f|
                f.read
            end
            avatar_file = File.new("public/qq_avatar/#{self.qq}.jpg", "wb")
            avatar_file.write(qq_avatar)
        rescue => e
            avatar_file = File.open("public/qq_avatar/qq_avatar.jpg")
        ensure
            self.avatar = avatar_file
            avatar_file.close
        end
    end

end
