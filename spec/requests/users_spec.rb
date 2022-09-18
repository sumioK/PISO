require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "access users" do
    it "ログインしていないとき新規登録画面に接続できる" do
      get "/signup"
      expect(response).to have_http_status(200)
    end

    it "ログインしていないときログイン画面に接続できる" do
      get login_path
      expect(response).to have_http_status(200)
    end

    it "ログインしていないとユーザー一覧画面に接続できない" do
      get users_index_path 
      expect(response).to have_http_status(302)
    end

    it "ログインしていないとユーザー詳細画面に接続できない" do
      get "/users/1"
      expect(response).to have_http_status(302)
    end

    it "ログインしていないとユーザー編集画面に接続できない" do
      get "/users/1/edit"
      expect(response).to have_http_status(302)
    end

    it "ログインしていないとユーザー削除できない" do
      user = User.create(
        name: "Jack",
        email: "jack@example.com",
        password: "password",
        introduction: "test"
      )
      post "/users/#{user.id}/delete"
      expect(response).to have_http_status(302)
    end

    it "ログインしていないとログアウトできない" do
      post logout_path
      expect(response).to have_http_status(302)
    end
  end
end