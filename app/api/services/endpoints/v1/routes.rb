# frozen_string_literal: true

module Services
  module Endpoints
    module V1
      class Routes < Grape::API
        version 'v1', using: :path
        format :json

        prefix :api

      end
    end
  end
end
