class User < ActiveRecord::Base

	has_one :spec
	has_one :faq
	acts_as_ferret :fields => [ :screen_name, :email ]

	attr_accessor :remember_me, :current_password

	SCREEN_NAME_MIN_LENGTH = 4
	SCREEN_NAME_MAX_LENGTH = 20
	PASSWORD_MIN_LENGTH = 4
	PASSWORD_MAX_LENGTH = 40
	EMAIL_MAX_LENGTH = 50

	SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH
	PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

	SCREEN_NAME_SIZE = 20
	PASSWORD_SIZE = 10
	EMAIL_SIZE = 30

	validates_uniqueness_of :screen_name, :email
	validates_confirmation_of :password
	validates_length_of     :screen_name, :within => SCREEN_NAME_RANGE
	validates_length_of     :password,    :within => PASSWORD_RANGE
	validates_length_of     :email,       :maximum => EMAIL_MAX_LENGTH


	validate   :all_fields

	def all_fields
		errors.add(:email, "must be valid") unless email.include? ("@")
		if screen_name.include? (" ")
			errors.add(:screen_name, "cannot include spaces.")
		end
	end

	def login!(session)
		session[:user_id] = self.id
	end

	def self.logout!(session, cookies)
		session[:user_id] = nil
		cookies.delete(:authorization_token) 
	end

	def clear_password!
		self.password = nil
	end

	def remember!(cookies)
		cookie_expiration = 10.years.from_now
		cookies[:remember_me] = { :value => "1", :expires => cookie_expiration }
        self.authorization_token = unique_identifier
        cookies[:authorization_token] = {:value => authorization_token, :expires => 10.years.from_now}
	end

	def forget!(cookies)
		cookies.delete(:remember_me)
        cookies.delete(:authorization_token)
	end

	def remember_me?
		remember_me == "1"
	end

	def clear_password!
		self.password = nil
		self.password_confirmation = nil
		self.current_password = nil
	end

	def correct_password?(params)
		current_password = params[:user][:current_password]
		password == current_password
	end

	def password_errors(params)
		self.password = params[:user][:password]
		self.password_confirmation = params[:user][:password_confirmation]
		valid?
		errors.add(:current_password, "Is incorrect")
	end

	def name
		spec.full_name.or_else(screen_name)
	end

	private

	def unique_identifier
		Digest::SHA1.hexdigest("#{screen_name}:#{password}")
	end

end
