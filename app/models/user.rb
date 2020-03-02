class User < ApplicationRecord
		has_many :articles
		before_save :ensure_password_is_strong
		VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		validates :username, presence: true,
							uniqueness: { case_sensitive: false },
							length: { minimum: 3, maximum: 25 }
		validates :email, presence: true, length: { maximum: 105 },
							uniqueness: { case_sensitive: false },
							format: { with: VALID_EMAIL_REGEX }
		validates :password ,length: {in: 6..20},on: [:create]
 
		private
			def ensure_password_is_strong
				if self.password.size < 6 
					errors.add(:password,"The Password is not strong")
				end
			end

		has_secure_password
end
