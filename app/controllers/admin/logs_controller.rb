# frozen_string_literal: true

module Admin
  class LogsController < ApplicationController
    def index
      @pagy, @logs = pagy(Log.includes([:user]).order(created_at: :desc), items: 20)
    end
  end
end
