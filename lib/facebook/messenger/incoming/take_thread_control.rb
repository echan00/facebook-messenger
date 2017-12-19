module Facebook
  module Messenger
    module Incoming
      # The Referral class represents an incoming Facebook Messenger pass_thread_control.
      #
      # https://developers.facebook.com/docs/messenger-platform/referral-params
      class TakethreadControl
        include Facebook::Messenger::Incoming::Common

        def previous_owner_app_id
          @messaging['take_thread_control']['previous_owner_app_id']
        end

        def metadata
      		@messaging['take_thread_control']['metadata']
        end

      end
    end
  end
end