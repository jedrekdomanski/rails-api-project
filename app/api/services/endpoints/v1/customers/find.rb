# frozen_string_literal: true

module Services
  module Endpoints
    module V1
      module Customers
        class Find < Grape::API
          params do
            optional :last_name, type: String
            optional :first_name, type: String
          end

          class Error < StandardError
            attr_reader :params

            def initialize(message: '', params: {})
              @params = params
              super(message)
            end
          end

          NoUserWithGivenFirstName   = Class.new(Error)
          NoUserWithGivenLasttName   = Class.new(Error)

          helpers do
            def find_customer_by_first_name(first_name)
              customer = Customer.find_by(first_name: first_name)
              raise NoUserWithGivenFirstName.new(params: privatized_params) unless customer

              customer
            end

            def find_customer_by_last_name(last_name)
              customer = Customer.find_by(last_name: last_name)
              raise NoUserWithGivenLasttName.new(params: privatized_params) unless customer

              customer
            end

            def privatized_params
              {
                first_name: params[:first_name],
                last_name: params[:last_name]
              }
            end
          end

          rescue_from NoUserWithGivenFirstName do |e|
            message = 'No user with given first name'
            error!({ error: :first_name_not_found, message: message, params: e.params }, 404)
          end

          rescue_from NoUserWithGivenLasttName do |e|
            message = 'No user with given last name'
            error!({ error: :last_name_not_found, message: message, params: e.params }, 404)
          end

          get :find do
            if params[:first_name].present?
              customer = find_customer_by_first_name(params[:first_name])
              json_success(Services::Entities::V1::Customer.new(customer))
            elsif params[:last_name].present?
              customer = find_customer_by_last_name(params[:last_name])
              json_success(Services::Entities::V1::Customer.new(customer))
            else
              message = 'Missing search params'
              error!({ error: :missing_params, message: message, params: privatized_params }, 422)
            end
          end
        end
      end
    end
  end
end
