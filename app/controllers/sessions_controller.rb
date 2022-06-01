# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_current_user, only: %i[create new]
  before_action :require_current_user, only: %i[destroy]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      sign_in user
      redirect_to root_path
    else
      flash[:alert] = 'Incorrect email and/or password!'
      redirect_to new_sessions_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
