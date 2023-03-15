require 'rails_helper'
RSpec.describe 'user#Show', type: :feature do
  describe 'User Model' do
    before(:each) do
      @user1 = User.create(name: 'David',
                           photo: 'Andy.png',
                           bio: 'Lorem.',
                           post_counter: 0)
      @user2 = User.create(name: 'Angela',
                           photo: 'Andy.png',
                           bio: 'Lorem.',
                           post_counter: 0)
      visit root_path
      @post1 = Post.create(title: 'First Post', text: 'This is my first post', comment_counter: 0, likes_counter: 0,
                           author: @user1)
      @post2 = Post.create(title: 'Second Post', text: 'This is my second post', comment_counter: 0, likes_counter: 0,
                           author: @user1)
      @post3 = Post.create(title: 'Third Post', text: 'This is my third post', comment_counter: 0, likes_counter: 0,
                           author: @user1)
      @post4 = Post.create(title: 'Fourth Post', text: 'This is my fourth post', comment_counter: 0, likes_counter: 0,
                           author: @user1)
      visit user_path(@user1.id)
    end
    it "show user's profile picture" do
      all('img').each do |i|
        expect(i[:src]).to eq('Andy.png')
      end
    end

    it "show user's name" do
      expect(page).to have_content 'David'
    end

    it 'show number of posts per user' do
      expect(page).to have_content(4)
    end

    it "show user's bio." do
      expect(page).to have_content('Lorem.')
    end

    it "show user's first 3 posts." do
      expect(page).to have_content 'This is my fourth post'
      expect(page).to have_content 'This is my third post'
      expect(page).to have_content 'This is my second post'
    end

    it "show button that lets me view all of a user's posts." do
      expect(page).to have_link('See all posts')
    end

    it "When I click on a user post, it redirects me to that post's show page" do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user1, @post_1)
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user1)
    end
  end
end
