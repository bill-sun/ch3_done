# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ActiveRecord::Base
  attr_accessible :name, :email

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  

  # 6.2.1 Validating Presence
  validates :name, :presence => true,
            :length   => { :maximum => 50 }  # 6.2.2 Length Validation
  # validates(:name, :presence => true) # the two forms are equivient
  validates :email, :presence             =>   true, # 6.2.1 Validating Presence
                    :format               =>   { :with => email_regex }, # 6.2.3 Format Validation
		            #		    :uniqueness => true # 6.2.4 Uniqueness Validation
                    :uniqueness => { :case_sensitive => false }
  
end
