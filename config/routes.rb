PaypalAdaptiveSdk::Application.routes.draw do

  resources :orders do
    collection do
      get :paid
      get :revoked
      post :ipn
    end
  end

  root :to => 'orders#index'
  
end
