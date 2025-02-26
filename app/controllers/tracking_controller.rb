class TrackingController < ApplicationController
  def tracking
    # logging
    Rails.logger.info "Tracking page accessed"

    @tracking_id = params[:tracking_id]
    Rails.logger.info "Searching shipment with tracking id :##{@tracking_id}"

    @air_shipments = AirShipment.where(tracking_id: @tracking_id)
    @ocean_shipments = OceanShipment.where(tracking_id: @tracking_id)

    # Rails.logger.debug "Found Air Shipments: #{@air_shipments.count}"
    # Rails.logger.debug "Found Ocean Shipments: #{@ocean_shipments.count}"
  end

  def search
    tracking_id = params[:tracking_id]
    Rails.logger.info "Searching shipment with tracking id :##{tracking_id}"

    @air_shipments = AirShipment.where(tracking_id: tracking_id).presence || []
    @ocean_shipments = OceanShipment.where(tracking_id: tracking_id).presence || []

    # render :search_results
  end
end