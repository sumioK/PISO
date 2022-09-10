require 'rails_helper'

RSpec.describe Post, type: :model do
  it "valid while image content " do
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

  it "valid while only image" do
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
  
  it "can not post without images" do
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

  it "if update's image is null image doesn't change" do
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

  it "if update has image , image changes" do
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

  it "destroy method work" do
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
