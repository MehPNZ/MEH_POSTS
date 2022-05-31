module Admin
  class UsersController < ApplicationController
    before_action :set_user!, only: %i[edit update destroy]

    def index
      @pagy, @users = pagy(User.order(created_at: :desc))
    end

    def edit
    end
    
    def update
      if @user.update user_params
        redirect_to admin_users_path, notice: "User updated!"
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: "User destroy!"
    end

    private

    def set_user!
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :role)
    end

  end
end