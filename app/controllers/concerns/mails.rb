# frozen_string_literal: true

module Mails
  extend ActiveSupport::Concern

  included do
    private

    def user_mailer
      if params[:action] == 'destroy'
      UserMailer.with(user: current_user, action: params[:action],
                      type: params[:controller], post: @post).send_email.deliver_now
      else
      UserMailer.with(user: current_user, action: params[:action],
                   type: params[:controller], post: @post).send_email.deliver_later
      end
    end
  end
end
