module Ruboty
  module Actions
    class Notification < ::Ruboty::Actions::Base
      def call
        notifications = ::Ruboty::Ragoon::Notification.new
        unless notifications.empty?
          message.reply(":new: #{notifications.unread_count}件の新着通知があります #{notification_url}")
        end
      end

      private

      def notification_url
        "#{::Ragoon::garoon_endpoint.gsub(/\?.*\Z/, '')}/notification/index"
      end
    end
  end
end
