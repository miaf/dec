Rails.application.routes.draw do
  scope '/:locale' do
    localized do
      root to: 'home#index'
      get 'about_us' => 'home#about', as: :about_us

      get 'log_in' => 'sessions#new'
      post 'log_in' => 'sessions#create', as: :create
      get 'log_out' => 'sessions#destroy'
      get 'forgot_password' => 'sessions#forgot_password'
      put 'forgot_password' => 'sessions#send_password_reset_instructions'

      get "password_reset" => "sessions#password_reset"
      put "password_reset" => "sessions#new_password"

      # get "change_password" => "sessions#change_password"
      # get 'services' => ''

      resources :users do
        member do
          get :confirm_email
        end
        # resources :services
      end
      get 'your_services' => 'services#your_services'
      resources :services
      resources :languages
      resources :service_languages
      get 'service_languages/:slug' => 'service_languages#details', as: :details
      resources :galleries
      get 'your_galleries' => 'galleries#your_galleries'
      resources :gallery_languages
    end
  end
end
