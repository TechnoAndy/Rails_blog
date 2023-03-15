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

    it 'shows posts title' do
      expect(page).to have_content('First Post')
    end

    it 'shows the person who wrote the post' do
      expect(page).to have_content('Andy')
    end

    it 'shows number of comments' do
      post = Post.first
      expect(post.comment_counter).to eql(3)
    end

    it 'shows number of likes' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it 'can see the post\'s body.' do
      expect(page).to have_content('This is my first post')
    end

    it 'can see the username of each commentor.' do
      expect(page).to have_content('Andy')
    end

    it 'can see the comments of each commentor.' do
      expect(@comment1.text).to eql('Well done!')
      expect(@comment2.text).to eql('Great Job!')
      expect(@comment3.text).to eql('Congrats!')
    end
  end
end
