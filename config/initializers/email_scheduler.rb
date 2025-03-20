require "rufus-scheduler"

# Ensure the scheduler is running or restart it if it's down
scheduler = Rufus::Scheduler.singleton

if scheduler.down?
  Rails.logger.info "Scheduler was stopped, restarting..."
  scheduler = Rufus::Scheduler.new
end

# Schedule CheckPreAlertEmailJob to run every day at midnight
# Every day at 6 AM: "0 6 * * *"
# Every hour: "0 * * * *"
scheduler.cron "0 4 * * *" do # Runs every day at 2 AM EST
  Rails.logger.info "Email Scheduler : Running CheckPreAlertEmailJob to send pre-alert emails."
  CheckPreAlertEmailJob.perform_later
end

Rails.logger.info "Email scheduler is running!"
