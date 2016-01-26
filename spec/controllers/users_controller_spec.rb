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

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe "GET 'show'" do

	before(:each) do
      #	  @user = Factory(:user)
      @user = FactoryGirl.create(:user)
      # User.stub!(:find, @user.id).and_return(@user) # stubbing technology but failed -- bill
	end

	it "should be successful" do
	  get :show, :id => @user
	  expect(response).to be_success
	end

	it "should find the right user" do
	  get :show, :id => @user
	  expect(assigns(:user)).to eql(@user)
	end

    # 7.3.2 A Name and a Gravatar

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end
  
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
	it "should have the right title" do
	  get 'new'
	  expect(response.body).to have_selector("title",
								             :text => "Sign up",
                                             :visible => false)
	end
  end
end
