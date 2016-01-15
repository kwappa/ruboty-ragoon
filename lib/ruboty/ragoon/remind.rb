module Ruboty
  module Ragoon
    class Remind
      include NotifyOnce
      attr_reader :brain

      NOTIFY_BEFORE_EVENT_START = 2 # minutes before start_at

      def initialize(brain)
        @brain = brain
      end

      def retrieve
        now = Time.now.localtime
        event = Event.new
        event.retrieve
      end
    end
  end
end
