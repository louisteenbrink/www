class GenerateCriticalCssJob
  include Sidekiq::Worker
  sidekiq_options queue: :default,
                  unique: :until_executing,
                  unique_args: :unique_args

  CSS_SEMAPHOR_NAMESPACE = 'critical-path-css-semaphor'.freeze

  def perform(route)
    return if route.nil?
    return if Rails.cache.exist?(route, namespace: CSS_SEMAPHOR_NAMESPACE)
    return unless CriticalPathCss.fetch(route).empty?
    Rails.cache.write(route, 'generating', { namespace: CSS_SEMAPHOR_NAMESPACE, expires_in: 10.minutes })
    CriticalPathCss.generate route
    Rails.cache.delete(route, namespace: CSS_SEMAPHOR_NAMESPACE)
  end

  def self.unique_args(args)
    args.first # route
  end
end
