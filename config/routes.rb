Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      root to: 'githubs#index'
    end
  end   
end
