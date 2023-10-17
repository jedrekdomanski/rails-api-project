Rails.application.routes.draw do
  get '/status', to: proc { [200, {}, ['OK']] }

  scope :api do
    mount Services::Api => '/'
  end
end
