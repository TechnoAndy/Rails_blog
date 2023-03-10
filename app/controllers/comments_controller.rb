class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = @post.author
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])
    if @comment.save
      render :new
    else
      redirect_to user_posts_path(@comment.post.author, @comment.post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
