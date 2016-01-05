module Ruboty
  module Actions
    class Notification < ::Ruboty::Actions::Base
      def call
        notifications = ::Ragoon::Services::Notification.new.retrieve
        unless notifications.empty?
          reply = ":new: 新着通知があります #{notification_url}"
          message.reply(reply)
        end
      end

      private

      def notification_url
        "#{::Ragoon::garoon_endpoint.gsub(/\?.*\Z/, '')}/notification/index"
      end
    end
  end
end
