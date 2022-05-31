# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def send_email
    @user = params[:user]
    @action = params[:action]
    @type = params[:type]
    @post = params[:post]

    mail(
      to: @user.email, subject: "APP MehPOSTs | #{@type.capitalize.chop} #{@action}"
    )
  end
end
