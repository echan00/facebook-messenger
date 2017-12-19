module Facebook
  module Messenger
    module Incoming
      # The Referral class represents an incoming Facebook Messenger pass_thread_control.
      #
      # https://developers.facebook.com/docs/messenger-platform/referral-params
      class PassThreadControl
        include Facebook::Messenger::Incoming::Common

        def new_owner_app_id
          @messaging['pass_thread_control']['new_owner_app_id']
        end

        def metadata
      		@messaging['pass_thread_control']['metadata']
        end

      end
    end
  end
end