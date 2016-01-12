module Ruboty::Actions::Ragoon
  class Event < ::Ruboty::Actions::Base
    include ::Ruboty::Actions::Ragoon

    def call
      target_date = parse_date(message[:date])
      events = ::Ruboty::Ragoon::Event.new(target_date)
      message.reply(events.render(private: private?))
    end

    private

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
