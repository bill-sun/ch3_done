require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
  #  describe "GET /layout_links" do
  #    it "works! (now write some real specs)" do
  #      get layout_links_index_path
  #      expect(response).to have_http_status(200)
  #    end
  #  end
  #

  describe "LayoutLinks" do


    it "returns http success" do
      get '/'
      expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      get '/contact'
      expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      get '/about'
      expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      get '/help'
      expect(response).to have_http_status(:success)
    end
	it "should have a signup page at '/signup'" do
	  get '/signup'
      expect(response).to have_http_status(:success)
	end
    
  end
  
end
