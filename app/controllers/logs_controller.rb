# frozen_string_literal: true

class LogsController < ApplicationController
  def show
    @pagy, @logs = pagy(Log.includes([:user]).order(created_at: :desc), items: 20)
  end
end
