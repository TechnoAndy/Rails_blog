class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :comment_counter
  after_destroy :comment_counter

  private

  def comment_counter
      if destroyed?
        post.decrement!(:comment_counter)
      end
        post.increment!(:comment_counter)
    end
  end
