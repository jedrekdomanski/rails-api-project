# frozen_string_literal: true

module Services
  class Error < Grape::Entity
    expose :code
    expose :message
  end

  class Api < Grape::API
    API_VERSION = 1.0
    format :json
    content_type :json, 'application/json'

    helpers SharedHelpers
    mount Hello
    mount Services::Endpoints::V1::Customers
  end
end
