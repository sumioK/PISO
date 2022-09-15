require 'rails_helper'

RSpec.describe Like, type: :model do
  it "like create work truth" do
    user = User.create(
      name: "A",
      email: "a@example.com",
      password: "password"
    )
    user2 = User.create(
      name: "B",
      email: "b@example.com",
      password: "password"
    )
    post = Post.create(
      user_id: user2.id,
      image: "image.jpg",
    )
    like = Like.create(
      user_id: user.id,
      post_id: post.id
    )
    expect(like).to be_valid
  end

  it "destroy like work truth" do
    user = User.create(
      name: "A",
      email: "a@example.com",
      password: "password"
    )
    user2 = User.create(
      name: "B",
      email: "b@example.com",
      password: "password"
    )
    post = Post.create(
      user_id: user2.id,
      image: "image.jpg",
    )
    like = Like.create(
      user_id: user.id,
      post_id: post.id
    )
    like.destroy
    expect(user.likes).to_not include like
  end
end