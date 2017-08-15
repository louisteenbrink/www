if defined?(HttpLog)
  HttpLog.configure do |config|
    config.enabled = true
    config.logger = Rails.logger
    config.color = { color: :white, background: :light_red }
  end
end
