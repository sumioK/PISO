require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "valid" do

    it "コメントが送信できる" do
      user = User.create(
        name: "Jack",
        email: "jack@example.com",
        password: "password",
        introduction: "test"
      )
      post = Post.create(
        user_id: user.id,
        image: "sample.jpg",
        content: "test"
      )
      comment = Comment.new(
        comment: "test comment",
        user_id: user.id,
        post_id: post.id
      )
      expect(comment).to be_valid
    end

    it "コメントが空の場合送信できない" do
      user = User.create(
        name: "Jack",
        email: "jack@example.com",
        password: "password",
        introduction: "test"
      )
      post = Post.create(
        user_id: user.id,
        image: "sample.jpg",
        content: "test"
      )
      comment = Comment.new(
        comment: "",
        user_id: user.id,
        post_id: post.id
      )
      expect(comment).to be_invalid
    end

    it "コメントが編集できる" do
      user = User.create(
        name: "Jack",
        email: "jack@example.com",
        password: "password",
        introduction: "test"
      )
      post = Post.create(
        user_id: user.id,
        image: "sample.jpg",
        content: "test"
      )
      comment = Comment.create(
        comment: "test comment",
        user_id: user.id,
        post_id: post.id
      )
      comment.update(
        comment: "changed comment"
      )
      expect(comment).to be_valid
    end

    it "コメントが空の場合更新できない" do
      user = User.create(
        name: "Jack",
        email: "jack@example.com",
        password: "password",
        introduction: "test"
      )
      post = Post.create(
        user_id: user.id,
        image: "sample.jpg",
        content: "test"
      )
      comment = Comment.create(
        comment: "",
        user_id: user.id,
        post_id: post.id
      )
      expect(comment).to be_invalid
    end
  end

  describe "メソッドの動作確認" do
    it "コメントの削除が行える" do
      user = User.create(
        name: "Jack",
        email: "jack@example.com",
        password: "password",
        introduction: "test"
      )
      post = Post.create(
        user_id: user.id,
        image: "sample.jpg",
        content: "test"
      )
      comment = Comment.create(
        comment: "",
        user_id: user.id,
        post_id: post.id
      )
      comment.destroy
      expect(user.comments).to_not include comment
    end
  end
end
