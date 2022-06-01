# frozen_string_literal: true

class PostsController < ApplicationController
  # before_action :require_current_user, except: %i[show index]
  before_action :find_post, only: %i[show destroy edit update]
  before_action :authorize_post!
  after_action :verify_authorized

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      record_log(@post, 'Create')
      user_mailer
      redirect_to posts_path, notice: 'New post created!'
    else
      render :new
    end
  end

  def index
    @pagy, @posts = pagy(Post.includes([:user]).order(created_at: :desc))
  end

  def show
    @comment = @post.comments.build
    @pagy, @comments = pagy(@post.comments.order(created_at: :desc))
  end

  def edit; end

  def update
    if @post.update post_params
      record_log(@post, 'Updated')
      user_mailer
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    record_log(@post, 'Destroy')
    user_mailer
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_post!
    authorize(@post || Post)
  end
end
