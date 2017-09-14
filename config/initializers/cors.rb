Rails.configuration.middleware.insert_before 0, Rack::Cors do
  allow do
    origins %w[
      https://www.lewagon.com
    ]
    resource '/assets/*'
  end
end
