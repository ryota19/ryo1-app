class Post < ApplicationRecord
    validates :text, presence: true

    belongs_to :user
    has_many :favorites, dependent: :destroy
end
