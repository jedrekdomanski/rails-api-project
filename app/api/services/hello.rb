# frozen_string_literal: true

module Services
  class Hello < Grape::API
    desc 'Useful for determining service is available' do
      detail 'This request can be used as a means to determine if services should ' \
             'be active and responding.'
      failure [
        { code: 401, message: 'Unauthorized', model: Services::Error },
        { code: 403, message: 'Forbidden', model: Services::Error }
      ]
    end

    get :hello do
      json_success message: 'Hello!'
    end
  end
end
