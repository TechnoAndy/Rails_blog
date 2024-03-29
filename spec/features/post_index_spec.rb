require 'rails_helper'
RSpec.describe 'posts#index', type: :feature do
  describe 'Post spec' do
    before(:each) do
      @user = User.create(name: 'Andy', photo: 'Andy.png', bio: 'Lorem.', post_counter: 0)

      @post1 = Post.create(title: 'First Post', text: 'This is my first post', comment_counter: 0, likes_counter: 0,
                           author: @user)
      @post2 = Post.create(title: 'Second Post', text: 'This is my second post', comment_counter: 0, likes_counter: 0,
                           author: @user)
      @post3 = Post.create(title: 'Third Post', text: 'This is my third post', comment_counter: 0, likes_counter: 0,
                           author: @user)

      @comment1 = Comment.create(text: 'Well done!', author: User.first,
                                 post: Post.first)
      @comment2 = Comment.create(text: 'Great Job!', author: User.first, post: Post.first)
      @comment3 = Comment.create(text: 'Congrats!', author: User.first, post: Post.first)

      visit(user_posts_path(@user.id))
    end

    it "shows user's profile picture" do
      all('img').each do |i|
        expect(i[:src]).to eq('Andy.png')
      end
    end

    it 'shows the users username' do
      expect(page).to have_content('Andy')
    end

    it 'shows number of posts of user has written' do
      # post = Post.all
      expect(page).to have_content(@user.post_counter.to_s)
    end

    it 'shows posts title' do
      expect(page).to have_content('First Post')
    end

    it 'can see some of the post detail' do
      expect(page).to have_content 'This is my first post'
    end

    it 'can see the first comment on a post' do
      expect(@comment1.text).to eql('Well done!')
    end

    it 'can see how many comments a post has.' do
      post = Post.first
      expect(page).to have_content(post.comment_counter)
    end

    it 'can see how many likes a post has.' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it 'shows a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_content 'Pagination'
    end

    it "redirects the user to the post's show page after clickin on it" do
      click_link 'First Post'
      expect(page).to have_current_path user_post_path(@post1.author_id, @post1)
    end
  end
end
