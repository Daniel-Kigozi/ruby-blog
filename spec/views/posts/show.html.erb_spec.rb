require 'rails_helper'

RSpec.describe 'Posts Show', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Daniel',
      photo_link: 'https://drive.google.com/file/d/1wA3g1uPsU7KtTliYiwYhjHJXNM30k2Aq/view?usp=sharing',
      bio: 'BCS',
      posts_counter: 0
    )

    @user1 = User.create(
      name: 'David',
      bio: 'Web Developer',
      photo_link: 'https://drive.google.com/file/d/1wA3g1uPsU7KtTliYiwYhjHJXNM30k2Aq/view?usp=sharing',
      posts_counter: 5
    )

    @post = Post.create(
      author_id: @user.id,
      title: 'How to make a post',
      text: 'Click on the button "New Post" and fill the form',
      comments_counter: 0,
      likes_counter: 0
    )

    Comment.create(post_id: @post.id, user_id: @user1.id, text: 'I can\'t do it')
    Comment.create(post_id: @post.id, user_id: @user.id, text: 'Nothing is impossible')
    Comment.create(post_id: @post.id, user_id: @user1.id, text: 'Thanks')
    Like.create(post_id: @post.id, user_id: @user1.id)
  end

  describe 'Post show page' do
    it 'displays the post title' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('How to make a post')
    end

    it 'displays the post author' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('Daniel')
    end

    it 'displays the comments counter' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('Comments: 3')
    end

    it 'displays the likes counter' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('Likes: 1')
    end

    it 'displays the post body' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('Click on the button "New Post" and fill the form')
    end

    it 'displays the user name of each commentor' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('David')
    end

    it 'displays the comment text' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('I can\'t do it')
      expect(page).to have_content('Nothing is impossible')
      expect(page).to have_content('Thanks')
    end
  end
end
