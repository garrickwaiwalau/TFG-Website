class AboutController < ApplicationController
  def about
    # logging
    Rails.logger.info "About page accessed"
  end
end
