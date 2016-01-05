module Ruboty
  module Handlers
    class Ragoon < Base
      on(/grn event (?<date>.+)/, name: 'schedule', description: 'retrieve schedule from garoon')
      on(/grn notice/, name: 'notification',  description: 'show new notification from garoon')

      def schedule(message)
        ::Ruboty::Actions::Event.new(message).call
      end

      def notification(message)
        ::Ruboty::Actions::Notification.new(message).call
      end
    end
  end
end
