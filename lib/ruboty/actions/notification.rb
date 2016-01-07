module Ruboty
  module Actions
    class Notification < ::Ruboty::Actions::Base
      def call
        notifications = ::Ruboty::Ragoon::Notification.new.list

        unless notifications.empty?
          reply = [":new: #{notifications.count}件の新着通知があります #{notification_url}"]
          notifications.each do |n|
            reply.push "#{n.id} #{n.module_type} #{n.module_icon} #{n.unread} #{n.recieved_at} #{n.subject}"
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
end
