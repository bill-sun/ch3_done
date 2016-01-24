# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string
#  salt               :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'digest'
class User < ActiveRecord::Base

  attr_accessor :password # 7.1.1 Password Validations
  attr_accessible :name, :email, :password, :password_confirmation

  # 6.2.1 Validating Presence
  validates :name, :presence => true, # = validates(:name, :presence => true)
            :length   => { :maximum => 50 }  # 6.2.2 Length Validation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  
  validates :email, :presence             =>   true, # 6.2.1 Validating Presence
            :format               =>   { :with => email_regex }, # 6.2.3 Format Validation
		    #		    :uniqueness => true # 6.2.4 Uniqueness Validation
            :uniqueness => { :case_sensitive => false }

  # 7.1.1 Password Validations
  validates :password, :presence     => true,
            :confirmation => true, # Automatically create the virtual attribute
            # 'password_confirmation'
            :length       => { :within => 6..40 }

  # 7.1.3 An Active Record Callback
  before_save :encrypt_password
  # Return true if the user's password matches the submitted password.

  # 7.2.1 A Secure Password Test
  def has_password?(submitted_password)
	# Compare encrypted_password with the encrypted version of
	# submitted_password.
    # 7.2.3 Implementing has_password?
    encrypted_password == encrypt(submitted_password)    
  end

  # 7.1.3 An Active Record Callback
  private
  def encrypt_password
    self.salt = make_salt if new_record? # 7.2.3 Implementing has_password?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
