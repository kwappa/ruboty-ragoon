module Ruboty
  module Ragoon
    class Notification
      attr_reader   :list, :brain

      def initialize(brain)
        @brain = brain
        retrieve
      end

      def retrieve
        new_notifications = ::Ragoon::Services::Notification.new.retrieve
                            .map { |data| Item.new(data) }
                            .find_all { |item| item.unread }

        notified_ids = @brain.data['notification_notified_ids'] || []
        new_ids = new_notifications.map(&:id)
        notified_ids &= new_ids
        not_notified_ids = new_ids - notified_ids
        @brain.data['notification_notified_ids'] = notified_ids + new_ids

        @list = new_notifications.find_all { |n| not_notified_ids.include?(n.id) }
      end

      def unread_count
        @list.count
      end

      def empty?
        unread_count == 0
      end

      class Item
        attr_accessor :id, :module_type, :module_icon, :unread, :recieved_at, :subject, :url

        DEFAULT_ICON = ':information_source:'

        APPLICATION_ICONS = {
          'grn.schedule'                   => ':memo:',              # スケジュール
          'grn.schedule.facility_approval' => DEFAULT_ICON,          # 施設の利用申請
          'grn.message'                    => ':incoming_envelope:', # メッセージ
          'grn.bulletin'                   => ':clipboard:',         # 掲示板
          'grn.cabinet'                    => ':open_file_folder:',  # ファイル管理
          'grn.phonemessage'               => ':phone:',             # 電話メモ
          'grn.mail'                       => ':mailbox_with_mail:', # メール
          'grn.workflow'                   => ':inbox_tray:',        # ワークフロー
          'grn.report'                     => DEFAULT_ICON,          # マルチレポート
          'grn.space'                      => DEFAULT_ICON,          # スペース
          'grn.space.discussion'           => DEFAULT_ICON,          # スペースのディスカッション
          'grn.space.todo'                 => DEFAULT_ICON,          # スペースの共有ToDo
        }.freeze

        def initialize(data)
          @id          = data[:item].to_i
          @module_type = data[:module_id].gsub('grn.', '').gsub('.', '_').to_sym
          @module_icon = APPLICATION_ICONS[data[:module_id]]
          @unread      = data[:is_history] == 'false'
          @recieved_at = Time.parse(data[:receive_datetime])
          @subject     = data[:subject]
          @url         = data[:abstract_url]
        end

        def format
          "#{@module_icon} #{@subject[0 .. 30]} #{@url}"
        end
      end
    end
  end
end
