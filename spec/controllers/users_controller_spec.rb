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
