module Ruboty
  module Ragoon
    class Remind
      include NotifyOnce
      attr_reader :brain, :event

      NOTIFY_BEFORE_EVENT_START = 3 # minutes before start_at

      def initialize(brain)
        @brain = brain
      end

      def retrieve
        now = Time.now.localtime

        @event = Event.new
        @event.filter_events do |event|
          begin
            event_start = Time.parse(event[:start_at]).localtime
            event_start.between?(now, now + NOTIFY_BEFORE_EVENT_START * 60)
          rescue
            false
          end
        end

        new_event_ids = not_notified_ids(@event.events.map { |event| event[:id] })
        @event.filter_events do |event|
          new_event_ids.include?(event[:id])
        end

        @event
      end
    end
  end
end
