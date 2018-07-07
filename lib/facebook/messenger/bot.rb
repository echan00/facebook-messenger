require 'facebook/messenger/bot/error_parser'
require 'facebook/messenger/bot/exceptions'

module Facebook
  module Messenger
    # The Bot module sends and receives messages.
    module Bot
      include HTTParty

      base_uri 'https://graph.facebook.com/v3.0/me'

      EVENTS = %i[
        message
        delivery
        postback
        optin
        read
        account_linking
        referral
        message_echo
        message_request
        pass_thread_control
        take_thread_control
        app_roles
        feed
        logging
        standby
      ].freeze

      class << self
        # Deliver a message with the given payload.
        #
        # message - A Hash describing the recipient and the message*.
        #
        # * https://developers.facebook.com/docs/messenger-platform/send-api-reference#request
        #
        # Returns a String describing the message ID if the message was sent,
        # or raises an exception if it was not.
        def deliver(message, access_token:)
          response = post '/messages',
                          body: JSON.dump(message),
                          format: :json,
                          query: {
                            access_token: access_token
                          }
          Facebook::Messenger::Bot::ErrorParser.raise_errors_from(response)
          response.body
          
          json = {'qs': {"access_token": access_token},'uri': base_uri+"/messages", 'json': message, 'method': "POST", 'responseBody': response.body}
          trigger(:logging, json)
        end

        # Register a hook for the given event.
        #
        # event - A String describing a Messenger event.
        # block - A code block to run upon the event.
        def on(event, &block)
          unless EVENTS.include? event
            raise ArgumentError,
                  "#{event} is not a valid event; " \
                  "available events are #{EVENTS.join(',')}"
          end

          hooks[event] = block
        end

        # Receive a given message from Messenger.
        #
        # payload - A Hash describing the message.
        #
        # * https://developers.facebook.com/docs/messenger-platform/webhook-reference
        def receive(payload)
          callback = Facebook::Messenger::Incoming.parse(payload)
          event = Facebook::Messenger::Incoming::EVENTS.invert[callback.class]
          trigger(event.to_sym, callback)
        end

        # Used for receiving webhooks about feed changes (updates to fb page), NOT MESSENGER
        def receive_standby(payload)        	
        	trigger(:standby, Facebook::Messenger::Incoming::Standby.new(payload))
        end

        # Used for receiving webhooks about feed changes (updates to fb page), NOT MESSENGER
        def receive_convo(payload)
        	trigger(:feed, payload)
        end

        # Used for logging 
        def logging(payload)
          trigger(:logging, payload)
        end

        # Trigger the hook for the given event.
        #
        # event - A String describing a Messenger event.
        # args - Arguments to pass to the hook.
        def trigger(event, *args)
          hooks.fetch(event).call(*args)
        rescue KeyError
          $stderr.puts "Ignoring #{event} (no hook registered)"
        end

        # Return a Hash of hooks.
        def hooks
          @hooks ||= {}
        end

        # Deregister all hooks.
        def unhook
          @hooks = {}
        end

        # Default HTTParty options.
        def default_options
          super.merge(
            read_timeout: 300,
            headers: {
              'Content-Type' => 'application/json'
            }
          )
        end
      end
    end
  end
end
