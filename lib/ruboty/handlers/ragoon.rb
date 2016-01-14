module Ruboty
  module Handlers
    class Ragoon < Base
      on(/grn event(?<date>\Z|\s+.+)/, name: 'schedule', description: 'retrieve schedule from garoon')
      on(/grn notice/, name: 'notification',  description: 'show new notification from garoon')
      on(/grn remind/, name: 'remind', description: 'remind event before few minutes')

      def schedule(message)
        ::Ruboty::Actions::Ragoon::Event.new(message).call
      end

      def notification(message)
        ::Ruboty::Actions::Ragoon::Notification.new(message).call
      end

      def remind(message)
        ::Ruboty::Actions::Ragoon::Remind.new(message).call
      end
    end
  end
end
