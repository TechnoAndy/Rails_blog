class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author = current_user
    @like.post = Post.find(params[:post_id])
    if @like.save
      render :new
    else
      redirect_to user_posts_path(@like.post.author, @like.post)
    end
  end
end
