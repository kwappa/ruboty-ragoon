module Ruboty
  module Handlers
    class Ragoon < Base
      on(/ragoon( me)? (?<date>.+)/, name: 'schedule', description: 'retrieve schedule from garoon')

      def schedule(message)
        target_date = Date.parse(message[:date]) rescue Date.today
        message.reply(target_date.to_s)
      end
    end
  end
end
