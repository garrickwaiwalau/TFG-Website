class SendPreAlertEmailJob < ApplicationJob
  queue_as :default

  def perform(ocean_shipment_id)
    ocean_shipment = OceanShipment.find(ocean_shipment_id)

    begin
      Rails.logger.info "Sending scheduled email of shipment ##{ocean_shipment.tracking_id}"

      # Attempt to send the email
      UserMailer.pre_alert_email(ocean_shipment).deliver_now
      Rails.logger.info "Successfully sent scheduled email of shipment ##{ocean_shipment.tracking_id}"

      # Update the email_sent flag only if the email is sent successfully
      ocean_shipment.update(pre_alert_completed: true)
      Rails.logger.info "updated email_sent flag of shipment ##{ocean_shipment.tracking_id}"

    rescue StandardError => e
      Rails.logger.error "Failed to send email for OceanShipment ID #{ocean_shipment.tracking_id}: #{e.message}"
    end
  end
end
