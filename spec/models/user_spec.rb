# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', posts_counter: 0) }

  context 'validations' do
    before(:each) { subject.save }

    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'should be invalid when name is not present' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'should be invalid when posts_counter is not a number' do
      subject.posts_counter = 'invalid'
      expect(subject).not_to be_valid
    end
  end

  context '#recent_posts' do
    before(:each) do
      subject.save
      @post1 = subject.posts.build(title: 'Title', likes_counter: 0, comments_counter: 0)
      @post2 = subject.posts.build(title: 'Title2', likes_counter: 0, comments_counter: 0)
      @post1.save
      @post2.save
    end

    it "should return all the user's posts when there are 3 or fewer, sorted from newest to oldest" do
      posts = subject.recent_posts
      expect(posts).to eq([@post2, @post1])
    end

    it "should return the user's 3 most recent posts when there are more than 3, sorted from newest to oldest" do
      post3 = subject.posts.build(title: 'Title3', likes_counter: 0, comments_counter: 0)
      post4 = subject.posts.build(title: 'Title4', likes_counter: 0, comments_counter: 0)
      post3.save
      post4.save
      posts = subject.recent_posts
      expect(posts).to eq([post4, post3, @post2])
    end
  end
end
