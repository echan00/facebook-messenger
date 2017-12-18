module Facebook
  module Messenger
    module Incoming
      # The Referral class represents an incoming Facebook Messenger pass_thread_control.
      #
      # https://developers.facebook.com/docs/messenger-platform/referral-params
      class AppRoles
        include Facebook::Messenger::Incoming::Common

        def app_roles
          @messaging['app_roles']
        end

      end
    end
  end
end