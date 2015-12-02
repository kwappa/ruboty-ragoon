module Ruboty
  module Handlers
    class Ragoon < Base
      on(/ragoon( me)? (?<date>.+)/, name: 'schedule', description: 'retrieve schedule from garoon')

      def schedule(message)
        target_date = Date.parse(message[:date]) rescue Date.today
        events = ::Ruboty::Ragoon::Event.new(target_date)
        message.reply(events.render)
      end
    end
  end
end
