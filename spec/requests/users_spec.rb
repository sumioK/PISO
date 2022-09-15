require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "access users" do
    it "access signup without login" do
      get "/signup"
      expect(response).to have_http_status(200)
    end

    it "access login without login" do
      get login_path
      expect(response).to have_http_status(200)
    end

    it "can not access index without login" do
      get users_index_path 
      expect(response).to have_http_status(302)
    end

    it "can not access show without login" do
      get "/users/1"
      expect(response).to have_http_status(302)
    end

    it "can not access edit without login" do
      get "/users/1/edit"
      expect(response).to have_http_status(302)
    end

    it "can not access delete without login" do
      user = User.create(
        name: "Jack",
        email: "jack@example.com",
        password: "password",
        introduction: "test"
      )
      post "/users/#{user.id}/delete"
      expect(response).to have_http_status(302)
    end

    it "can not access logout without login" do
      post logout_path
      expect(response).to have_http_status(302)
    end
  end
end