require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
  describe "GET /layout_links" do
    it "works! (now write some real specs)" do
      get layout_links_index_path
      expect(response).to have_http_status(200)
    end
  end

  describe "LayoutLinks" do

    it "should have a Home page at '/'" do
      get '/'
      expect(response.body).to have_selector('title', :text => "Home", :visible => false)
    end

    it "should have a Contact page at '/contact'" do
      get '/contact'
      expect(response.body).to have_selector('title', :text => "Contact", :visible => false)
    end

    it "should have an About page at '/about'" do
      get '/about'
      expect(response.body).to have_selector('title', :text => "About", :visible => false)
    end

    it "should have a Help page at '/help'" do
      get '/help'
      expect(response.body).to have_selector('title', :text => "Help", :visible => false)
    end
  end
  
end

#	  expect(response.body).to have_selector("title",
#								             :text => "Ruby on Rails Tutorial Sample App | Home",
#                                             :visible => false)
#
