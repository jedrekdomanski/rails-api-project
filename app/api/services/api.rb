# frozen_string_literal: true

module Services
  class Error < Grape::Entity
    expose :code
    expose :message
  end

  class Api < Grape::API
    API_VERSION = 1.0
    format :json
    prefix :services

    helpers SharedHelpers

    after do
      header 'X-Version', API_VERSION.to_s
    end

    mount Hello
    mount Services::Endpoints::V1::Routes
  end
end
