require 'rails_helper'

RSpec.describe 'Post Index', type: :system do
  describe 'post page' do
    before(:each) do
      @user = User.create!(
        name: 'Daniel',
        bio: 'BCS',
        photo_link: 'https://drive.google.com/file/d/1wA3g1uPsU7KtTliYiwYhjHJXNM30k2Aq/view?usp=sharing'
      )
      @post = @user.posts.create(title: 'Post1', text: 'This is my first post')
      @comment = Comment.create(text: 'First comment', user_id: @user.id, post_id: @post.id)
      Like.create(user_id: @user.id, post_id: @post.id)

      visit(user_posts_path(@user.id))
    end

    it 'shows the users username' do
      expect(page).to have_content('Daniel')
    end

    it 'shows number of posts by user' do
      expect(page).to have_content('number of posts')
    end

    it 'shows posts title' do
      expect(page).to have_content('Post1')
    end

    it 'shows some of the posts body' do
      expect(page).to have_content 'This is my first post'
    end

    it 'shows the first comment on a post' do
      expect(page).to have_content 'First comment'
    end

    it 'shows how many comments a post has.' do
      save_and_open_page
      expect(page).to have_content('Comments')
    end

    it 'shows how many likes a post has.' do
      expect(page).to have_content('Likes')
    end

    it 'shows a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_content('Pagination')
    end

  end
end