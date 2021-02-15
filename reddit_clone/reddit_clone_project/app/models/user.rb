class User < ApplicationRecord
    
    
    validates :username, uniqueness: true, presence: true
    validates :password, presence: true, length: {minimum: 6, allow_nil: true}
    validates :session_token, presence: true 

    attr_reader :password

    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if user.nil?
        if user.is_password?(password)
            return user
        else
            nil
        end
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        BCrypt::password.new(self.password_digest).is_password?(password)
    end


    def reset_session_token
        self.session_token = SecureRandom.base64
        self.save
        self.session_token
    end

    private


    def ensure_session_token
        self.session_token ||= SecureRandom.base64
    end

    has_many :subs,
    foreign_key: :moderator_id,
    class_name: :Sub
end
