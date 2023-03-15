require 'rails_helper'

RSpec.describe 'UserShow', type: :feature do
  before :each do
    @user_one = User.create(name: 'Andy', photo: 'https://img.bidorbuy.co.za/image/fetch/c_limit,h_448,q_auto:eco,w_448/https://justaddink.co.za/wp-content/uploads/2022/09/JAI_AD_-61980235.png',
                            bio: 'Full-Stack Developer from South Africa', post_counter: 2)

    @user_two = User.create(name: 'Nickson', photo: 'https://cdn.shopify.com/s/files/1/1878/0085/products/diy-paint-by-number-kit-for-adults-on-canvas-african-beauty-paint-by-number_530x@2x.jpg?v=1617198917',
                            bio: 'Web Developer from Uganda', post_counter: 3)

    @first_post = Post.create(author: @user_one, title: 'Hello', text: 'First post', comment_counter: 3,
                              likes_counter: 2)

    @second_post = Post.create(author: @user_one, title: 'Second', text: 'Second post', comment_counter: 1,
                               likes_counter: 2)

    @third_post = Post.create(author: @user_one, title: 'Third', text: 'Third post', comment_counter: 2,
                              likes_counter: 1)

    @user_posts = @user_one.posts
  end

  describe 'Show page features' do
    before :each do
      visit user_path(@user_one)
    end

    it "should show the user's profile picture" do
      expect(page).to have_css("img[src*='#{@user_one.photo}']")
    end

    it "should show the user's name" do
      expect(page).to have_content(@user_one.name)
    end

    it "should show the user's bio" do
      expect(page).to have_content(@user_one.bio)
    end

    it "should show a button to see all user's posts" do
      expect(page).to have_link('See all posts')
    end

    it "should redirect to the user's posts index page when the 'See all posts' button is clicked" do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@user_one))
    end
  end
end
