class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_save :increment_post_counter
  after_save :recent_comments

  after_destroy :increment_post_counter

  def increment_post_counter
    if destroyed?
      author.decrement!(:post_counter)
    else
      author.increment!(:post_counter)
    end
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
