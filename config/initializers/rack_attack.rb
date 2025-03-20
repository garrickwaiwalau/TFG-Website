class Rack::Attack
  # Limit ALL form submissions to 5 per minute per IP
  throttle("form submissions by ip", limit: 3, period: 60) do |request|
    if request.post? && request.path.match?(/contact|index|quote/)
      request.ip
    end
  end

  throttle("login attempt by ip", limit: 10, period: 60) do |request|
    if request.post? && request.path.start_with?("/auth")
      request.ip
    end
  end

  throttle("tracking by ip", limit: 10, period: 10) do |request|
    if request.path.start_with?("/tracking")
      request.ip
    end
  end

  ActiveSupport::Notifications.subscribe(/rack_attack/) do |name, start, finish, request_id, payload|
    req = payload[:request]
    if %i[throttle].include? req.env["rack.attack.match_type"]
      info = "[Rack-attack] Remote Ip: #{req.ip}"
      rack_attack_throttle_data = req.env["rack.attack.throttle_data"]["req/ip"]
      Rails.logger.info info
      Rails.logger.info rack_attack_throttle_data
    end
  end

  self.throttled_responder = lambda do |_env|
    html = ActionView::Base.empty.render(file: "public/403.html")
    [403, {"Content-Type" => "text/html"}, [html]]
  end

  ### Custom Throttle Response ###

  # By default, Rack::Attack returns an HTTP 429 for throttled responses,
  # which is just fine.
  #
  # If you want to return 503 so that the attacker might be fooled into
  # believing that they've successfully broken your app (or you just want to
  # customize the response), then uncomment these lines.
  # self.throttled_responder = lambda do |env|
  #  [ 503,  # status
  #    {},   # headers
  #    ['']] # body
  # end
end
