require 'rails_helper'

RSpec.describe "Api::V1::Graphs", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/graph/show"
      expect(response).to have_http_status(:success)
    end
  end

end
