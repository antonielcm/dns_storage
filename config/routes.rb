Rails.application.routes.draw do
  namespace :api, path: '', constraints: { format: 'json' } do
    namespace :v1 do
      resources :dns_records, only: [:show, :create]
    end
  end
end
