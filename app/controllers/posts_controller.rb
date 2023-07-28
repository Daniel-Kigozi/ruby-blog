class PostsController < ApplicationController
  before_action :set_post, only: %i[show like]

  def index
    @posts = Post.all
    @user = User.find_by(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:success] = 'Post has been created successfully!'
      redirect_to user_posts_path(current_user.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
