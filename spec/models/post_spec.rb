require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Daniel Kigozi', posts_counter: 0) }
  let(:post) { Post.create(author_id: user.id, title: 'Sample Post', likes_counter: 0, comments_counter: 0) }
  let!(:comment1) { Comment.create(post_id: post.id, user_id: user.id, text: 'Sample Comment') }
  let!(:comment2) { Comment.create(post_id: post.id, user_id: user.id, text: 'Sample Comment') }
  let!(:comment3) { Comment.create(post_id: post.id, user_id: user.id, text: 'Sample Comment') }
  let!(:comment4) { Comment.create(post_id: post.id, user_id: user.id, text: 'Sample Comment') }
  let!(:comment5) { Comment.create(post_id: post.id, user_id: user.id, text: 'Sample Comment') }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#update_user_posts_counter' do
    it 'updates the user posts_counter attribute' do
      puts "Before saving post: #{user.posts_counter}"
      post.save
      user.reload
      update = user.posts_counter
      puts "After saving post: #{update}"
      expect(update).to eq(2)
    end
  end
end
