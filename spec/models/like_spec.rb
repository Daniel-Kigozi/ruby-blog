require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user, name: 'Daniel Kigozi', posts_counter: 0) }
  let(:post) { FactoryBot.create(:post, author: user, title: 'First Post', comments_counter: 0, likes_counter: 0) }
  let(:like) { FactoryBot.create(:like, post: post, user: user) }

  describe '#update_like_counter' do
    it 'updates the post likes_counter attribute' do
      like.save
      post.reload
      expect(post.likes_counter).to eq(2)
    end
  end
end
