require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "access posts" do
    it "access post/index without login" do
      get posts_index_path
      expect(response).to have_http_status(200)
    end
    
    it "can not access post/new without login" do 
      get posts_new_path
      expect(response).to have_http_status(302)
    end

    it "can not access posts/serch without login" do
      get posts_serch_path
      expect(response).to have_http_status(302)
    end

    it "can not access posts/create without login" do
      post posts_create_path
      expect(response).to have_http_status(302)
    end
    it "can not access posts/destroy without login" do
      post "/posts/1/destroy"
      expect(response).to have_http_status(302)
    end

    it "can not access post/show without login" do
      get "/posts/1"
      expect(response).to have_http_status(302)
    end
  end
end

