require 'rails_helper'

RSpec.describe 'root page features' do
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
        author: @user2, title: 'Hello', text: 'Art is anything you can get away with', comment_counter: 3,
        likes_counter: 28
      )
    ]

    visit user_posts_path(@user.first, @posts.first)
  end

  describe '#PostShowPage' do
    it 'Should display the post author' do
      expect(page).to have_content(@posts.first.author.name)
    end

    it 'Should display the number of comments' do
      expect(page).to have_content(@posts.first.comment_counter)
    end

    it 'Should display the number of likes' do
      expect(page).to have_content(@posts.first.likes_counter)
    end

    it 'should display the post body' do
      expect(page).to have_content(@posts.first.text)
    end

    it 'should display the name of the commentor' do
      @posts.first.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end
  end
end
