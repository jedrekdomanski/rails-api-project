# frozen_string_literal: true

module Services
  module SharedHelpers
    extend Grape::API::Helpers

    def error_message(message, error_code, extra = {})
      { status: 'error', error_message: message, error_code: error_code }.update extra
    end

    def json_exception!(e, http_code, message = e.message, full_details = false)
      fields           = {}
      fields[:details] = e.message if full_details && (Rails.env.development? || Rails.env.test?)
      json_error message, extra: fields, http_code: http_code
    end

    def json_error(message, error_code: 'unspecified', http_code: 500, extra: {})
      fields = error_message message, error_code, extra
      error! fields, http_code
    end

    def json_success(hsh)
      status 200
      hsh = hsh.serializable_hash if hsh.respond_to?(:serializable_hash)
      msg = hsh.delete(:status_message) || ''
      { status: 'ok', message: msg, response: hsh }
    end

    def api_error!(args = [])
      message, status = args
      error!(message, status)
    end
  end
end
