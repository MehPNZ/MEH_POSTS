module Admin
  class UsersController < ApplicationController

    def index
      @pagy, @users = pagy(User.order(created_at: :desc))
    end

  end
end