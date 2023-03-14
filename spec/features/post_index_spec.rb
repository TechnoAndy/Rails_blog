require 'rails_helper'

RSpec.describe '#UserIndex', type: :feature do
  before(:each) do
    @user = [
      @user1 = User.create(
        name: 'Black Beauty',
        photo: 'https://img.bidorbuy.co.za/image/fetch/c_limit,h_448,q_auto:eco,w_448/https://justaddink.co.za/wp-content/uploads/2022/09/JAI_AD_-61980235.png',
        bio: 'Natural hair expert.',
        post_counter: 3
      ),
      @user2 = User.create(
        name: 'Abstract Woman',
        photo: 'https://cdn.shopify.com/s/files/1/1878/0085/products/diy-paint-by-number-kit-for-adults-on-canvas-african-beauty-paint-by-number_530x@2x.jpg?v=1617198917',
        bio: 'Abstract artist.',
        post_counter: 7
      )
    ]

    @posts = [
      @post1 = Post.create(
        author: @user1, title: 'Hello', text: 'Naturally beautiful', comment_counter: 1, likes_counter: 8
      ),
      @post2 = Post.create(
        author: @user2, title: 'Hello', text: 'Art is anything you can get away with', comment_counter: 3, likes_counter: 28
      )
    ]

    @comments = [
      Comment.create(post: @post1, author: @user1,
                     text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
      Comment.create(post: @post2, author: @user2,
                     text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    ]

    visit user_posts_path(@user.first, @posts.first)
  end

  describe 'Post#Index' do
    it 'should display the users profile picture' do
      expect(page).to have_css("img[src='#{@user.first.photo}']")
    end

    it 'should display the user name' do
      expect(page).to have_content(@user.first.name)
    end

    it 'should display the number of posts' do
      expect(page).to have_content(@user.first.post_counter)
    end

    it 'should display the body of the post' do
      expect(page).to have_content(@posts.first.text)
    end

    it 'should display the post text' do
      expect(page).to have_content(@posts.first.text)
    end

    it 'should display the number of comments' do
      expect(page).to have_content(@posts.first.comment_counter)
    end

    it 'should display the number of likes' do
      expect(page).to have_content(@posts.first.likes_counter)
    end

    it 'should include a section for paginations' do
      expect(page).to have_content('Pagination')
    end
  end
end
