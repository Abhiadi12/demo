class User < ApplicationRecord
		has_many :articles,dependent: :destroy
		has_many :comments,dependent: :destroy
		#before_save :has_a_strong_password , on: :update
		VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		validates :username, presence: true,
							uniqueness: { case_sensitive: false },
							length: { minimum: 3, maximum: 25 }
		validates :email, presence: true, length: { maximum: 105 },
							uniqueness: { case_sensitive: false },
							format: { with: VALID_EMAIL_REGEX }
		validates :password,length: {in: 6..20},on: :create
	#	validates :password ,length: {in: 6..20},on: :create
		has_secure_password # for btCrypt
end