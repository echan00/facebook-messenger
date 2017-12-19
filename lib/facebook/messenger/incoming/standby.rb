module Facebook
  module Messenger
    module Incoming
      # The Referral class represents an incoming Facebook Messenger pass_thread_control.
      #
      # https://developers.facebook.com/docs/messenger-platform/referral-params
      class Standby
        include Facebook::Messenger::Incoming::Common

        def message?
          @messaging['message'].present?
        end

        def delivery?
          @messaging['delivery'].present?
        end

        def read?
          @messaging['read'].present?
        end                

        def text
          @messaging['message']['text']
        end

        def seq
          @messaging['message']['seq']
        end
      end
    end
  end
end