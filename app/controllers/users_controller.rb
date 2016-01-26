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

class UsersController < ApplicationController
  def show # 6.3.2 User Model, View, Controller
    @user = User.find(params[:id])
	@title = @user.name # 7.3.2 A Name and a Gravatar
  end
  def new
	@title = "Sign up"
  end
end
