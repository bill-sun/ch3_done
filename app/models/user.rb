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
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

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
  private
  def encrypt_password
    self.encrypted_password = encrypt(password)
  end
  def encrypt(string)
    string # Only a temporary implementation!
  end
end
