require 'uuid'
require 'digest/sha1'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  include ActiveModel::Dirty
	has_many :entries
	before_save :create_hashed_password, if: :password_changed?

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

	validates :email, :presence => true, :length => { :within => 5..100 },
		:format=>EMAIL_REGEX, :confirmation => true, :uniqueness=>true
	validates :password, :presence => true

  class << self
    def authenticate(email='', password = '')
      user = User.find_by_email( email)
      if user && user.password == get_hashed_password(password)
        return user
      else
        return false
      end
    end

    def get_hashed_password(password)
      Digest::SHA1.hexdigest(password) unless password.nil?
    end

    def make_salt
      UUID.state_file = false
      UUID.generator.next_sequence
      UUID.new.generate
    end
  end

  def to_json
    {
      email: email,
      private_token: token,
      entries: entries.pluck(:id)
    }.to_json
  end

	def create_hashed_password
		unless password.blank?
			self.salt ||= User.make_salt
			self.password = User.get_hashed_password(password)
      self.token = Digest::SHA1.hexdigest(password + salt)[0..20]
		end

	end

end
