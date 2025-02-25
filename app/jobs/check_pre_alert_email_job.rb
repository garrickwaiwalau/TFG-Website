class CheckPreAlertEmailJob < ApplicationJob
  queue_as :default

  def perform
    # Find shipments where `status_send_date` is today and email has not been sent
    OceanShipment.where(status_send_date: Date.today)
                 .where(pre_alert_completed: [false, nil])
                 .where.not(pre_alert_email: [nil, ""])
                 .find_each do |shipment|
      # Send email for each eligible shipment
      SendPreAlertEmailJob.perform_later(shipment.id)
    end
  end
end
