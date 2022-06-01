# frozen_string_literal: true

module Admin
  class LogsController < BaseController
    before_action :authorize_user!
    after_action :verify_authorized

    def index
      @pagy, @logs = pagy(Log.includes([:user]).order(created_at: :desc), items: 20)
    end

    def authorize_user!
      authorize(@log || Log)
    end
  end
end
