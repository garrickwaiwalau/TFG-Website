class ServiceController < ApplicationController
  def service
    # logging
    Rails.logger.info "Service page accessed"
  end
end
