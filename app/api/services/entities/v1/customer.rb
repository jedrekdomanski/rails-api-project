# frozen_string_literal: true

module Services
  module Entities
    module V1
      class Customer < Grape::Entity
        expose :first_name
        expose :id
        expose :last_name
      end
    end
  end
end
