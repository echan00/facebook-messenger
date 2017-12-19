require 'httparty'

module Facebook
  module Messenger
    module Handover
      include HTTParty

      base_uri 'https://graph.facebook.com/v2.6/me'

      format :json

      module_function

      def pass_thread_control(settings, access_token:)
      	puts settings
        response = post '/pass_thread_control', body: settings.to_json, query: {
          access_token: access_token
        }

        raise_errors(response)

        true
      end

      def take_thread_control(settings, access_token:)
      	puts settings
        response = post '/take_thread_control', body: settings.to_json, query: {
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
