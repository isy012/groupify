class User < ActiveRecord::Base
  has_many :attendances, class_name: "Attendance", foreign_key: "user_id", dependent: :destroy
  has_many :groups, class_name: "Group", through: :attendances

	attr_accessor :remember_token
	before_save { self.email = email.downcase }
	
	validates(:name, 	presence: true, 
						length: {maximum: 30})

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates(:email, 	presence: true, 
						format: { with: VALID_EMAIL_REGEX }, 
						uniqueness: {case_sensitive: false})

	has_secure_password
	
	#validates :password, length: { minimum: 6 }


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end
