class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :increment_posts_counter
  after_save :recent_comments

  validates :title, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  def increment_posts_counter
    author.increment!(:post_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
