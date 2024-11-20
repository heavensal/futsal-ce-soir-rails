require 'rails_helper'

RSpec.describe "Events::Teams", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/events/teams/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/events/teams/update"
      expect(response).to have_http_status(:success)
    end
  end

end
