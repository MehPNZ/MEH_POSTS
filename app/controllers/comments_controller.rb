# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_post, only: %i[create destroy]
  after_action :user_mailer, except: new

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build params_comment_create
    if @comment.save
      record_log(@comment, 'Create')
      user_mailer
      redirect_to post_path(@post)
    else
      @comments = @post.comments.order(created_at: :desc)
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post.comments.delete(params[:id])
    record_log(@comment, 'Destroy')
    user_mailer
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.includes([:avatar_attachment]).find(params[:post_id])
  end

  def params_comment_create
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
