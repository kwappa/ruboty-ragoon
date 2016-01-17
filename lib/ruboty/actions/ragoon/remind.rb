module Ruboty::Actions::Ragoon
  class Remind < ::Ruboty::Actions::Base
    include ::Ruboty::Actions::Ragoon

    def call
      reminder = ::Ruboty::Ragoon::Remind.new(message.robot.brain)
      events = reminder.retrieve
      if events.count > 0
        message.reply(events.render(private: private?, template: 'remind'))
      end
    end
  end
end
