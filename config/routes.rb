Rails.application.routes.draw do
  get "carts/show"
  get "carts/index"
  devise_for :users
  root to: "homes#top"
  # マイページのルート
  resources :mypage, only: [:show]

  # 商品関連ルート
  resources :products

  # 注文関連ルート
  resources :orders, only: [:index, :new, :create] do 
    collection do
      post :confirm   # 注文確認
    end

    member do
      get :complete  # 注文完了
    end
  end

  resources :carts, only: [:show, :index] do
  # セッションカートに商品を追加、数量を更新、商品を削除するアクション
    collection do
      post :add_product  # カートに商品を追加
    end
    member do
      delete :remove_item  # カートから商品を削除
      post :update_quantity  # カート内の商品個数変更
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
