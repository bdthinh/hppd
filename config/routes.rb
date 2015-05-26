Rails.application.routes.draw do
  resources :categories
  resources :posts
  resources :videos
  resources :user_profiles

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root  "studio#index"
  post "/", to: "studio#index"
  get   "introduction", to: "studio#introduction", as: :introduction
  get "user_profiles/:id/public_profile", to: "user_profiles#public_profile", as: :public_profile
  get   "admin/users", to: "admin#show_users", as: :show_users
  get   "admin/videos", to: "admin#show_videos", as: :show_videos
  post "admin/videos/:video_id/publish", to: "admin#publish_video", as: :publish_video
  post "admin/videos/:video_id/unpublish", to: "admin#unpublish_video", as: :unpublish_video
  post "admin/videos/:video_id/assign", to: "admin#assign_video_showed_on_tv", as: :assign_video
  post "admin/videos/:video_id/unassign", to: "admin#unassign_video_showed_on_tv", as: :unassign_video
  get   "contact_us", to: "studio#contact_us", as: :contact_us
  post  "videos/vote/:id", to: "videos#vote_video", as: :vote_video
  post  "videos/unvote/:id", to: "videos#unvote_video", as: :unvote_video
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end

