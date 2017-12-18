module Facebook
  module Messenger
    module Incoming
      # The Referral class represents an incoming Facebook Messenger pass_thread_control.
      #
      # https://developers.facebook.com/docs/messenger-platform/referral-params
      class MessageHandover
        include Facebook::Messenger::Incoming::Common

        def new_owner_app_id
          @messaging['pass_thread_control']['new_owner_app_id']
        end

        def metadata
          @messaging['pass_thread_control']['metadata']
        end

        def previous_owner_app_id
          @messaging['take_thread_control']['previous_owner_app_id']
        end

        def app_roles
          @messaging['app_roles']
        end

      end
    end
  end
end