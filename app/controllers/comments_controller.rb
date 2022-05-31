# frozen_string_literal: true

  class CommentsController < ApplicationController
    before_action :find_post, only: %i[create destroy update edit]
    before_action :find_comment, only: %i[destroy edit update]
    def new
      @comment = Comment.new
    end

    def create
      @comment = @post.comments.build params_comment_create
      if @comment.save
        record_log(@comment, 'Create')
        user_mailer
        redirect_to post_path(@post), notice: 'Comment created!'
      else
        @pagy, @comments = pagy(@post.comments.order(created_at: :desc))
        render 'posts/show'
      end
    end

    def edit; end

    def update
      if @comment.update comment_params
        record_log(@comment, 'Update')
        user_mailer
        redirect_to post_path(@post), notice: 'Comment update!'
      else
        @pagy, @comments = pagy(@post.comments.order(created_at: :desc))
        redirect_to :edit
      end
    end

    def destroy
      @post.comments.delete(params[:id])
      record_log(@comment, 'Destroy')
      user_mailer
      redirect_to post_path(@post), notice: 'Comment destroy!'
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_post
      @post = Post.includes([:avatar_attachment]).find(params[:post_id])
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end

    def params_comment_create
      params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end
  end
