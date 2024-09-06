class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def search
    @posts = Post.where('hashtags @> ARRAY[?]::varchar[]', params[:tag])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  before_action :authenticate_user!, only: [:create]
end
