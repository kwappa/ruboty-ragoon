module Ruboty::Actions::Ragoon
  class Notification < ::Ruboty::Actions::Base
    include ::Ruboty::Actions::Ragoon

    def call
      notifications = ::Ruboty::Ragoon::Notification.new(message.robot.brain)
      notifications.retrieve
      unless notifications.empty?
        reply = [":new: #{notifications.unread_count}件の新着通知があります #{notification_url}"]

        if private?
          reply += notifications.list.find_all(&:unread).map(&:format)
        end

        message.reply(reply.join("\n"))
      end
    end

    private

    def notification_url
      "#{::Ragoon::garoon_endpoint.gsub(/\?.*\Z/, '')}/notification/index"
    end
  end
end