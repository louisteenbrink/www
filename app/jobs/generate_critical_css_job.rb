class GenerateCriticalCssJob < ActiveJob::Base
  def perform(route)
    return if route.nil? || CriticalPathCss.fetch(route).empty?
    CriticalPathCss.generate route
  end

  def self.unique_args(args)
    args.first # route
  end
end
