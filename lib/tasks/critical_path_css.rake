require 'critical-path-css-rails'

namespace :critical_path_css do
  desc 'Generate critical CSS for the routes defined'
  task generate: :environment do
    CriticalPathCss.generate_all
  end

  desc 'Clear all critical CSS from the cache'
  task clear_all: :environment do
    CriticalPathCss.clear_matched('*')
  end

  desc 'Clear all critical CSS from the cache in 5 minutes in a job'
  task enqueue_clear_all_in_five_minutes: :environment do
    ClearCriticalCssJob.set(wait: 5.minutes).perform_later
  end
end
