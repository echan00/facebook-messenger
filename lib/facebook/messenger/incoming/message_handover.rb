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

        def previous_owner_app_id
          @messaging['take_thread_control']['previous_owner_app_id']
        end

        def app_roles
          @messaging['app_roles']
        end

        def metadata
        	if @messaging['take_thread_control'].present?
        		@messaging['take_thread_control']['metadata']
        	elsif @messaging['pass_thread_control'].present?
        		@messaging['pass_thread_control']['metadata']
        	end        		          
        end

      end
    end
  end
end