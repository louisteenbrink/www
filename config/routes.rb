Rails.application.routes.draw do

  # config/static_routes.yml
  STATIC_ROUTES.each do |template, locale_paths|
    locale_paths.each do |locale, page|
      get page => "pages##{template}", template: template, locale: locale.to_sym, as: "#{template}_#{locale}".to_sym
    end
  end

  get "apply/(:city)" => "applies#new", locale: :en, city: /#{Static::CITIES.keys.join("|")}|/, as: :apply_en
  get "postuler/(:city)" => "applies#new", locale: :fr, city: /#{Static::CITIES.keys.join("|")}|/, as: :apply_fr
  resource :apply, only: %s(create)
  scope "(:locale)", locale: /fr|en/ do
    root to: "pages#home"
    get "faq", to: "pages#show", template: "faq", as: :faq
    get "jobs", to: "pages#show", template: "jobs", as: :jobs
    get "tv", to: "pages#tv", template: "tv", as: :tv
    get "alumni" => "students#index", as: :alumni
    get ":city" => "cities#show", city: /#{Static::CITIES.keys.join("|")}|/, as: :city
    resources :projects, only: [:show]
    resources :students, only: [:show]
    get "blog", to: 'posts#index'
    get "blog/:slug", to: 'posts#show'
  end

  resources :subscribes, only: :create

  # Redirects
  get 'marseille', to: redirect('aix-marseille')

  # API
  resource :cache, only: :destroy
end

# Create helper for static_routes
Rails.application.routes.url_helpers.module_eval do
  STATIC_ROUTES.each do |route, _|
    define_method "#{route}_path".to_sym do |args = {}|
      locale = args[:locale] || :fr
      self.send(:"#{route}_#{locale}_path")
    end

    define_method "#{route}_url".to_sym do |args = {}|
      locale = args[:locale] || :fr
      self.send(:"#{route}_#{locale}_url")
    end
  end
end
