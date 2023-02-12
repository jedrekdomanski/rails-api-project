# frozen_string_literal: true

module Services
  module Endpoints
    module V1
      class Customers < Grape::API
        resource :customers do
          desc 'Find all customers' do
            success Services::Entities::V1::Customer
            failure [
              { code: 401, message: 'Unauthorized', model: Services::Error },
              { code: 403, message: 'Forbidden', model: Services::Error }
            ]
          end

          desc 'Obtain customer information' do
            success Services::Entities::V1::Customer
            failure [
              { code: 401, message: 'Unauthorized', model: Services::Error },
              { code: 403, message: 'Forbidden', model: Services::Error }
            ]
          end

          params do
            requires :id, type: String, desc: 'Customer ID.'
          end

          get ':id' do
            customer = Customer.find_by(id: params[:id])

            if customer.present?
              customer_entity = Services::Entities::V1::Customer.new(customer)
              json_success(customer_entity)
            else
              error!({ message: 'Customer not found.', id: params[:id] }, 404)
            end
          end

          desc 'Create a customer.'

          params do
            requires :first_name, type: String, desc: 'First Name.'
            requires :last_name, type: String, desc: 'Last Name.'
          end

          post do
            Customer.create!(
              first_name: params[:first_name],
              last_name: params[:last_name]
            )
          end

          desc 'Update a customer.'
          params do
            requires :id, type: String, desc: 'Customer ID.'
            requires :first_name, type: String, desc: 'First Name.'
            requires :last_name, type: String, desc: 'Last Name.'
          end

          put ':id' do
            Customer.find(params[:id]).update(
              first_name: params[:first_name],
              last_name: params[:last_name]
            )
          end

          desc 'Delete a customer.'
          params do
            requires :id, type: String, desc: 'Customer ID.'
          end

          delete ':id' do
            Customer.find(params[:id]).destroy
          end
        end
      end
    end
  end
end
