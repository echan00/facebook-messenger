require 'httparty'

module Facebook
  module Messenger
    module Handover
      include HTTParty

      base_uri 'https://graph.facebook.com/v3.0/me'

      format :json

      module_function

      def pass_thread_control(settings, access_token:)
        response = post '/pass_thread_control', body: settings, query: {
          access_token: access_token
        }

        raise_errors(response)

        true
      end

      def take_thread_control(settings, access_token:)
        response = post '/take_thread_control', body: settings, query: {
          access_token: access_token
        }

        raise_errors(response)

        true
      end

      def raise_errors(response)
        raise Error, response['error'] if response.key? 'error'
      end

      class Error < Facebook::Messenger::FacebookError; end
    end
  end
end
