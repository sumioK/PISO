class User < ApplicationRecord
has_secure_password
validates :introduction, length: {maximum: 250}
validates :name, presence: true
validates :email, presence: true ,uniqueness: true, format: {with: /@/,message:"不正なメールアドレスです"}
validates :password_digest, presence: true

    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    has_many :relationships, foreign_key: :following_id
    has_many :followings, through: :relationships, source: :follower

    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
    has_many :followers, through: :reverse_of_relationships, source: :following

    def is_followed_by?(user)
        reverse_of_relationships.find_by(following_id: user.id).present?
    end


end
