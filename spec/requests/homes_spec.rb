require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /top" do
    it "ホーム画面に接続できる" do
      get "/homes/top"
      expect(response).to have_http_status(:success)
    end
  end

end
