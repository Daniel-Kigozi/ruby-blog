require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before :each do
    @user = User.create(name: 'Daniel',
                        photo_link: 'https://drive.google.com/file/d/1wA3g1uPsU7KtTliYiwYhjHJXNM30k2Aq/view?usp=sharing',
                        bio: 'BCS', posts_counter: 12)
    @post = Post.create(title: 'Physics', text: 'This is not my first post', comments_counter: 10, likes_counter: 10,
                        author: @user)
  end

  describe 'User show page' do
    before(:each) { visit user_path(id: @user.id) }

    it 'has a container element that has a class named info' do
      expect(page).to have_css('.info')
    end

    it "displays the user's profile picture" do
      expect(page).to have_xpath("//img[@src='#{@user.photo_link}']")
    end

    it 'shows the number of posts of each user' do
      User.all.each do |user|
        expect(page).to have_content("Total number of posts are: #{user.posts_counter}")
      end
    end

    it "displays the user's username" do
      expect(page).to have_content(@user.name)
      expect(page).to have_link(@user.name, href: user_path(id: @user.id))
    end

    it "shows the user's bio" do
      expect(page).to have_content('Bio')
      expect(page).to have_content(@user.bio)
    end

    it 'shows the first 3 posts of the user' do
      @user.recent_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'has a button to view all user posts' do
      expect(page).to have_link('Show All', href: user_posts_path(user_id: @user.id))
    end

    it 'displays the recent posts of the user' do
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@post.text)
      expect(page).to have_content('Comments: 10')
      expect(page).to have_content('Likes: 10')
    end

    it 'has links to view individual posts' do
      click_link(@post.title)
      expect(page).to have_current_path(user_post_path(@user, @post))
    end

    it 'redirects to open all posts of a user' do
      click_link('Show All')
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
