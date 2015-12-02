module Ruboty
  module Handlers
    class Ragoon < Base
      on(/ragoon( me)? (?<date>.+)/, name: 'schedule', description: 'retrieve schedule from garoon')

      def schedule(message)
        target_date = parse_date(message[:date])
        events = ::Ruboty::Ragoon::Event.new(target_date)
        message.reply(events.render)
      end

      private

      def parse_date(date)
        case date.downcase
        when 'today'
          Date.today
        when 'tomorrow'
          Date.today + 1
        when 'yesterday'
          Date.today - 1
        else
          Date.parse(date)
        end
      rescue
        Date.today
      end
    end
  end
end
