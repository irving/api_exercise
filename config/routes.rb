Rails.application.routes.draw do

  namespace :v1 do
    resources :boards do
      resources :columns
    end

    resources :columns do
      resources :stories
    end
  end
end
