# frozen_string_literal: true

module Services
  module Endpoints
    module V1
      class Routes < Grape::API
        version 'v1', using: :path
        format :json

        namespace :customers do
          mount Services::Endpoints::V1::Customers::Find
        end
      end
    end
  end
end
