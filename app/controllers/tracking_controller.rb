class TrackingController < ApplicationController
  def tracking
    # logging
    Rails.logger.info "Tracking page accessed"
  end
end
