CRITICAL_PATH_CSS_ROUTES = CriticalPathCss::CssFetcher.new.instance_variable_get(:"@config").instance_variable_get(:"@configurations")["routes"] || []
