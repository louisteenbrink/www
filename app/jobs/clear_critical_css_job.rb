class ClearCriticalCssJob < ActiveJob::Base
  def perform
    Rails.logger.info "Clearing all critical CSS"
    CriticalPathCss.clear_matched('*')

    Rails.logger.info "Generating Critical CSS for Home page"
    GenerateCriticalCssJob.perform_now("/")
  end
end
