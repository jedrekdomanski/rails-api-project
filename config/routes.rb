Rails.application.routes.draw do
  get '/status', to: proc { [200, {}, ['OK']] }

  namespace :api do
    namespace :v1 do
      mount Services::Api => '/'
    end
  end
end
