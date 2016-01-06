module Ruboty
  module Actions
    class Notification < ::Ruboty::Actions::Base
      def call
        notifications = ::Ragoon::Services::Notification.new.retrieve
                        .find_all { |n| n[:is_history] == 'false' }

        unless notifications.empty?
          reply = ":new: #{notifications.count}件の新着通知があります #{notification_url}"
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
