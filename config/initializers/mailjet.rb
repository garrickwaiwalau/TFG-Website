Mailjet.configure do |config|
  config.api_key = ENV["MAILJET_API_KEY"]
  config.secret_key = ENV["MAILJET_SECRET_KEY"]
  config.default_from = "no-reply@trustfreightglobal.com"
end

ActionMailer::Base.smtp_settings = {
  address: "in-v3.mailjet.com",
  port: 587,
  user_name: ENV["MAILJET_API_KEY"],
  password: ENV["MAILJET_SECRET_KEY"],
  authentication: :plain,
  enable_starttls_auto: true
}
