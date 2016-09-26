module Ruboty
  module Ragoon
    class Notification
      include NotifyOnce

      attr_reader :list, :brain

      def initialize(brain)
        @brain   = brain
        @service = ::Ragoon::Services::Notification.new
      end

      def retrieve
        new_notifications = @service.retrieve
                            .map { |data| Item.new(data) }
                            .find_all { |item| item.unread }

        new_notification_ids = new_notifications.map(&:id)
        ids_to_notify = not_notified_ids(new_notification_ids)

        @list = new_notifications.find_all { |n| ids_to_notify.include?(n.id) }
      end

      def unread_count
        @list.count
      end

      def empty?
        unread_count == 0
      end

      def list_url
        "#{@service.garoon_endpoint.gsub(/\?.*\Z/, '')}/notification/index"
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
