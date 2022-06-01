# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    before_action :set_user!, only: %i[edit update destroy]
    before_action :authorize_user!
    after_action :verify_authorized

    def index
      @pagy, @users = pagy(User.order(created_at: :desc))
    end

    def edit; end

    def update
      if @user.update user_params
        redirect_to admin_users_path, notice: 'User updated!'
      else
        render :edit
      end
    end

    def destroy
      @user.avatar.purge
      @user.destroy
      redirect_to admin_users_path, notice: 'User destroy!'
    end

    private

    def set_user!
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :role)
    end

    def authorize_user!
      authorize(@user || User)
    end
  end
end
