require 'rails_helper'

RSpec.describe Post, type: :model do
  it "正常に投稿できる " do
    user = User.create(
      id: 1,
      name: "Jack",
      email: "jack@example.com",
      password: "password",
      introduction: "test"
  )
    post = Post.new(
      user_id: 1,
      image: "sample.jpg",
      content: "test"
    )
    expect(post).to be_valid
  end

  it "画像のみの投稿が可能" do
    user = User.create(
      id: 1,
      name: "Jack",
      email: "jack@example.com",
      password: "password",
      introduction: "test"
  )
    post = Post.new(
      user_id: 1,
      image: "sample.jpg"
    )
    expect(post).to be_valid
  end
  
  it "画像のない投稿はできない" do
    user = User.create(
      id: 1,
      name: "Jack",
      email: "jack@example.com",
      password: "password",
      introduction: "test"
  )
    post = Post.new(
      user_id: 1,
      image: nil,
      content: "test"
    )
    expect(post).to be_invalid
  end

  it "編集で画像を選択しない場合、投稿の画像は変化しない" do
    user = User.create(
      id: 1,
      name: "Jack",
      email: "jack@example.com",
      password: "password",
      introduction: "test"
    )
    post = Post.new(
      user_id: 1,
      image: "sample.jpg",
      content: "test"
    )
    post.update(
      content: "changed"
    )
      expect(post.content).to eq "changed"
      expect(post.image).to eq "sample.jpg"
  end

  it "編集時に画像を選択すると投稿画像が更新される" do
    user = User.create(
      id: 1,
      name: "Jack",
      email: "jack@example.com",
      password: "password",
      introduction: "test"
    )
    post = Post.new(
      user_id: 1,
      image: "sample.jpg",
      content: "test"
    )
    post.update(
      content: "changed",
      image: "change.jpg"
    )
    expect(post.content).to eq "changed"
    expect(post.image).to eq "change.jpg"
  end

  it "投稿の削除ができる" do
    user = User.create(
      id: 1,
      name: "Jack",
      email: "jack@example.com",
      password: "password",
      introduction: "test"
    )
    post = Post.new(
      user_id: 1,
      image: "sample.jpg",
      content: "test"
    )
    post.destroy!
    expect(user.posts).to_not include post
  end
end
