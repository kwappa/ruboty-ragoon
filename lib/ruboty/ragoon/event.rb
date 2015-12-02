module Ruboty
  module Ragoon
    class Event
      include ::Ruboty::Ragoon::Template

      attr_accessor :date
      attr_reader   :events

      def initialize(date = Date.today)
        @date = date
        self.retrieve
      end

      def retrieve
        @events ||= ::Ragoon::Services::Schedule.new.schedule_get_events(::Ragoon::Services.start_and_end(date))
      end

      def render(private: false)
        render_template('events', events: format(private), date: self.date)
      end

      private

      def format(private)
        @events.map { |event| format_event(event, private) }
      end

      def format_event(event, private)
        plan = event[:plan].to_s != '' ? "【#{event[:plan].strip}】" : ''
        period = if event[:allday]
                   '終日'
                 else
                   "#{format_time(event[:start_at])}〜#{format_time(event[:end_at])}"
                 end
        if !private && event[:private]
          title = '予定あり'
          facilities = ''
        else
          title = event[:title]
          facilities = event[:facilities].join(', ')
        end

        {
          plan:       plan,
          period:     period,
          title:      title,
          facilities: facilities,
          private:    event[:private],
        }
      end

      def format_time(time)
        if time.to_s == ''
          ''
        else
          Time.parse(time).localtime.strftime('%R')
        end
      end
    end
  end
end
