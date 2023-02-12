# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Endpoints::V1::Customers, type: :request do
  describe 'GET :id' do
    it 'returns a customer' do
      customer = Customer.create(first_name: 'John', last_name: 'Doe')

      get '/api/v1/customers/1'

      expected_response = {
        status: 'ok',
        message: '',
        response: {
          id: customer.id,
          first_name: customer.first_name,
          last_name: customer.last_name
        }
      }

      expect(parsed(response)).to include(expected_response)
    end
  end
end
