class Comment < ApplicationRecord
    belongs_to :author, class_name: 'User'
    belongs_to :post

    validates : text, presence: true

    def update_posts_counter
        post.increment!(:comment_counter)
    end
end