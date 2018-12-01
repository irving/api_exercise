Rails.application.routes.draw do

  namespace :v1 do
    resources :boards do
      resources :columns
    end

    resources :columns do
      resources :stories do
        get :find_by_attributes, on: :collection
      end
    end
  end
end
