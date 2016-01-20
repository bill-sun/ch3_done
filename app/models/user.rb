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

class User < ActiveRecord::Base
  attr_accessible :name, :email

  # 6.2.1 Validating Presence
  validates :name, :presence => true 
  # validates(:name, :presence => true) # the two forms are equivient
  validates :email, :presence => true
end
