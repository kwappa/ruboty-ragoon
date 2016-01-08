module Ruboty
  module Actions
    module Helpers
      def private?
        adapter = message.original[:robot].send(:adapter)
        return false unless adapter.private_methods.include?(:user_info)

        owner = adapter.send(:user_info, ENV['SLACK_OWNER_ID'])
        message.from.start_with?('D') && owner['name'] == message.from_name
      end
    end
  end
end
