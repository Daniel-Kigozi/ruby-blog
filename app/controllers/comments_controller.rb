class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(
      user_id: current_user.id,
      post_id: @post.id,
      text: params[:text]
    )
    return unless @comment.save

    redirect_to user_post_path(@comment.user.id, @post.id)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
