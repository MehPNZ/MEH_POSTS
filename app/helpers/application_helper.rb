# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def main_menu
    render partial: 'shared/menu'
  end

  def pagination(_obj)
    # rubocop:disable Rails/OutputSafety
    # rubocop:disable Rails/HelperInstanceVariable
    raw(pagy_bootstrap_nav(@pagy)) if @pagy.pages > 1
    # rubocop:enable Rails/OutputSafety
    # rubocop:enable Rails/HelperInstanceVariable
  end
end
