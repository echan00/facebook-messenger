module Facebook
  module Messenger
    module Incoming
      # The Referral class represents an incoming Facebook Messenger pass_thread_control.
      #
      # https://developers.facebook.com/docs/messenger-platform/referral-params
      class Standby
        include Facebook::Messenger::Incoming::Common

        def log_type
          if @messaging['message'].present?
          	if @messaging['message']['is_echo'] == true
          		return 'standby-message-echo'
	          else
		          return 'standby-message'
		        end
	        elsif @messaging['delivery'].present?
						return 'standby-delivery'
	        elsif	@messaging['postback'].present?
	        	return 'standby-postback'
        	elsif	@messaging['read'].present?
						return 'standby-read'
          end      
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