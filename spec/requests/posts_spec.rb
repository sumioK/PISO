require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "access posts" do
    it "投稿一覧にはログインしていなくても接続できる" do
      get posts_index_path
      expect(response).to have_http_status(200)
    end
    
    it "ログインしていないと新規投稿画面に接続できない" do 
      get posts_new_path
      expect(response).to have_http_status(302)
    end

    it "ログインしていないと投稿検索できない" do
      get posts_serch_path
      expect(response).to have_http_status(302)
    end

    it "ログインしていない新規投稿できない" do
      post posts_create_path
      expect(response).to have_http_status(302)
    end
    it "ログインしていないと投稿の削除ができない" do
      post "/posts/1/destroy"
      expect(response).to have_http_status(302)
    end

    it "ログインしていないと投稿詳細画面に接続できない" do
      get "/posts/1"
      expect(response).to have_http_status(302)
    end
  end
end

