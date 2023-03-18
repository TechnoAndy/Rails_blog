class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  after_save :comment_counter
  after_destroy :comment_counter

  private

  def comments_counter
    if destroyed?
      post.decrement!(:comment_counter)
    else
      post.increment!(:comment_counter)
    end
  end
end
