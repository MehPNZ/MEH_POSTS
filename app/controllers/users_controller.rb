# frozen_string_literal: true
require 'open-uri'

class UsersController < ApplicationController
  before_action :require_no_current_user, only: %i[new create]
  before_action :require_current_user, only: %i[edit update]
  before_action :set_user!, only: %i[edit update show]
  before_action :authorize_user!
 
  after_action :verify_authorized

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    set_avatar! 
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def show; end

  # def destroy # todo
  # end

  private

  def set_avatar!
    unless @user.avatar.attached?
      @user.avatar.attach(io: File.open('/Users/aleksandrmihailov/ruby/test-task/app/assets/images/no-foto.jpeg'),
                          filename: 'no-foto.jpg',
                          content_type: 'image/jpeg')
    end
  end
 
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :avatar)
  end

  def set_user!
    @user = User.includes([:avatar_attachment]).find(params[:id])
  end

  def authorize_user!
    authorize(@user || User)
  end
end
