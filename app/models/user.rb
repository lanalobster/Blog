class User < ActiveRecord::Base
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 30 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, 
    format: { with: VALID_EMAIL_REGEX }
    before_save { self.email = email.downcase }
    has_secure_password

    def self.search(search)
        if search
            self.where("username LIKE ?", "#{search}%")
        else
            User.all
        end
    end
end