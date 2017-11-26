class CachesController < ActionController::Base
  before_action :check_shared_secret!

  class HttpAuthorizationHeaderException < Exception; end

  def destroy
    Rails.logger.info "Clearing GraphQL cache from Kitt notification"
    $redis.keys("kitt/client*").each do |key|
      $redis.del key
    end

    # Hit / to re-warm cache.
    GenerateCriticalCssJob.perform_later("/")
    render body: nil
  end

  private

  def check_shared_secret!
    shared_secret = URI.parse(ENV.fetch('KITT_BASE_URL')).password
    expected_authorization = "Bearer #{shared_secret}"
    fail HttpAuthorizationHeaderException if request.headers['HTTP_AUTHORIZATION'] != expected_authorization
  end
end
