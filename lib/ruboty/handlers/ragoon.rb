module Ruboty
  module Handlers
    class Ragoon < Base
      on(/ragoon( me)? (?<date>.+)/, name: 'schedule', description: 'retrieve schedule from garoon')

      def schedule(message)
        ::Ruboty::Actions::Event.new(message).call
      end
    end
  end
end
