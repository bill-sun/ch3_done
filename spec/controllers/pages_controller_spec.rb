require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views
  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
	it "should have the right title" do
	  get :home
	  expect(response.body).to have_selector("title",
								             :text => "Ruby on Rails Tutorial Sample App | Home",
                                             :visible => false)

	end
    
  end

  describe "GET #contact" do
    it "returns http success" do
      get :contact
      expect(response).to have_http_status(:success)
    end
	it "should have the right title" do
	  get :contact
	  expect(response.body).to have_selector("title",
								             :text => "Ruby on Rails Tutorial Sample App | Contact",
                                             :visible => false)
	end
    
  end

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
	it "should have the right title" do
	  get :about
	  expect(response.body).to have_selector("title",
								             :text => "Ruby on Rails Tutorial Sample App | About",
                                             :visible => false)
	end
    
  end
  
  
end
