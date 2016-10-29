require 'rails_helper'

RSpec.describe Admin::MainController, type: :controller do

  describe "GET #login" do
    it "returns http success" do
      get :login
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #login_session" do
    it "returns http success" do
      get :login_session
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #logout" do
    it "returns http success" do
      get :logout
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #aboutus" do
    it "returns http success" do
      get :aboutus
      expect(response).to have_http_status(:success)
    end
  end

end
