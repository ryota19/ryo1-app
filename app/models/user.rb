class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    has_many :posts
    has_many :favorites, dependent: :destroy

    def already_favorited?(post)
        self.favorites.exists?(post_id: post.id)
    end
end
