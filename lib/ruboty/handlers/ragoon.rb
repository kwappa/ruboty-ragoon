module Ruboty
  module Handlers
    class Ragoon < Base
      on(/ragoon( me)? (?<date>.+)/, name: 'schedule', description: 'retrieve schedule from garoon')

      def schedule(message)
        target_date = parse_date(message[:date])
        events = ::Ruboty::Ragoon::Event.new(target_date)
        message.reply(events.render(private: check_private(message)))
      end

      private

      def check_private(message)
        owner = message.original[:robot].send(:adapter).send(:user_info, ENV['SLACK_OWNER_ID'])
        message.from.start_with?('D') && owner['name'] == message.from_name
      end

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
