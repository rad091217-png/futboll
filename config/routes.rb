Rails.application.routes.draw do
  resources :comments
  root "home#top"
  get "contacts/new"
  post "contacts/create"
  get "/column", to: "home#column"
  get "/signup", to: "users#signup"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :laliga_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :bundesu_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :premier_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :serie_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :league_one_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :eredivisie_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :jupiler_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :premera_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :scotish_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :euro_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :nations_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :champions_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :europe_posts, only: [:index, :create, :new, :destroy, :update, :edit, :show]
  resources :users
  resources :account_activations, only: [:edit]
  resources :relationships, only: [:create, :destroy]
  scope "/:locale" do
    resources :books
  end
  resource :profile, only: %i[show edit update]
  resources :users, only: [:index, :show]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
