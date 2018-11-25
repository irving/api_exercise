Rails.application.routes.draw do

  namespace :v1 do
    resources :boards do
      resources :columns
    end
  end
end
