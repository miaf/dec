class User < ActiveRecord::Base

	has_many :services, inverse_of: :user

	attr_accessor :password, :new_password, :previous_email, :previous_login_name, :previous_website, :remember_me
	# validates_presence_of :password
  validates_presence_of :password#, :on => :create
	validates_confirmation_of :password

	before_save :encrypt_password 
	before_create :confirmation_token

	validates :first_name,
						presence: true

	validates :last_name,
						presence: true

	validates :date_of_birth,
						presence: true

	validates :nationality,
						presence: true

	validates :country,
						presence: true

	validates :email,
						presence: true,
						uniqueness: true

	validates :phone,
						presence: true

	validates :address,
						presence: true

	validates :login_name,
						presence: true,
						uniqueness: true

	validates_confirmation_of :new_password, :if => Proc.new {|user| !user.new_password.nil? && !user.new_password.empty? }
	validates_presence_of :email, :if => Proc.new {|user| user.previous_email.nil? || user.email != user.previous_email}
	validates_presence_of :login_name, :if => Proc.new {|user| user.previous_login_name.nil? || user.login_name != user.previous_login_name}
	# validates_presence_of :website, :if => Proc.new {|user| user.previous_website.nil? || user.website != user.previous_website}
	validates_uniqueness_of :email, :if => Proc.new {|user| user.previous_email.nil? || user.email != user.previous_email}
	validates_uniqueness_of :login_name, :if => Proc.new {|user| user.previous_login_name.nil? || user.login_name != user.previous_login_name}



  def self.authenticate(login_name, password)
    user = User.find_by_login_name(login_name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      return user
    else
      return nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end  
  end 

  def email_activate
  	self.email_confirmed = true
  	self.confirm_token = nil
  	save!(validate: false)
  end

  def reset_password
  	
  end

  def to_s
  	return "#{self.first_name} #{self.last_name}"
  end

  def self.user_params
		return [:email, :first_name, :last_name, :date_of_birth, :gender, :address, :email_confirmed, :confirm_token,
						:confirmation_expires_after, :password_reset_token, :password_expires_after, :activated, :nationality,
						:phone, :password, :password_confirmation, :image_profile, :description, :login_name, :country]
	end

	private
	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s			
	    self.confirmation_expires_after = 7.days.from_now
	  end
	end

	def clear_password_reset(user)
	  user.password_expires_after = nil
	  user.password_reset_token = nil
	end

	def verify_new_password(passwords)
	  result = true

	  if passwords[:new_password].blank? || (passwords[:new_password] != passwords[:new_password_confirmation])
	    result = false
	  end

	  result
	end

end