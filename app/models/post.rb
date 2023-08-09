class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def recent_comments(max = 5)
    comments.includes(:author).order(created_at: :desc).limit(max)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
