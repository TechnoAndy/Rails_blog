class User < ApplicationRecord
    has_many :posts, add_foreign_key: 'author_id'	
    has_many :comments, add_foreign_key: 'author_id'
    has_many :likes, add_foreign_key: 'author_id'

    validates :name, format: { with /[a-zA-Z]/, message: "Only allows letters" }
    validates :photo, presence: true
    validates :bio, length: { maximum: 5, too_short: 'Bio should be more than 20 characters' }
    validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0}

    def most_recent_comments
        posts.order(created_at: :desc).limit(3)
    end
end