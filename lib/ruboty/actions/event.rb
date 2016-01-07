module Ruboty
  module Actions
    class Event < ::Ruboty::Actions::Base
      def call
        target_date = parse_date(message[:date])
        events = ::Ruboty::Ragoon::Event.new(target_date)
        message.reply(events.render(private: check_private(message)))
      end

      private

      def check_private(message)
        adapter = message.original[:robot].send(:adapter)
        return false unless adapter.respond_to?(:user_info)

        owner = adapter.send(:user_info, ENV['SLACK_OWNER_ID'])
        message.from.start_with?('D') && owner['name'] == message.from_name
      end

      def parse_date(date)
        date = date.strip.downcase
        case date
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
