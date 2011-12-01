Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :reports do
      get 'order_export', :on => :collection
    end
  end
end

