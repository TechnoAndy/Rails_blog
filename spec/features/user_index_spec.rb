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

    visit('/')
  end

  describe 'users#index' do
    it 'displays all the different usernames' do
      @user.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'displays the profile picture of the user' do
      @user.each do |user|
        expect(page).to have_css("img[src='#{user.photo}']")
      end
    end
    it 'displays the number of posts for each user' do
      @user.each do |user|
        expect(page).to have_content("Number of posts: #{user.post_counter}")
      end
    end

    describe 'GET /index' do
      it 'has a link to user show page' do
        expect(page).to have_selector("a[href='#{user_path(@user1.id)}']")
      end
    end
  end
end
