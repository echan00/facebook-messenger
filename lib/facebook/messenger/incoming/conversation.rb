module Facebook
  module Messenger
    module Incoming
      # The Conversation class represents an incoming webhook where FB page has updated
      #
      class Conversation
        attr_reader :convo

        def initialize(convo)
          @convo = convo
        end


      end
    end
  end
end
