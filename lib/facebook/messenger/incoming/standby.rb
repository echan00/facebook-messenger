module Facebook
  module Messenger
    module Standby
      # The Referral class represents an incoming Facebook Messenger pass_thread_control.
      #
      # https://developers.facebook.com/docs/messenger-platform/referral-params
      class MessageHandover
        include Facebook::Messenger::Incoming::Common

        def page_id
          @messaging['entry']['id']
        end

        def standby_messages
          @messaging['standby']
        end

      end
    end
  end
end