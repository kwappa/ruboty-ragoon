module Ruboty
  module Ragoon
    module NotifyOnce
      def not_notified_ids(new_item_ids)
        notified_item_ids = self.brain.data[brain_key] || []
        notified_item_ids &= new_item_ids
        self.brain.data[brain_key] = notified_item_ids + new_item_ids
        new_item_ids - notified_item_ids
      end

      def brain_key
        "#{self.class.name.downcase.gsub('::', '_')}_notified_ids"
      end
    end
  end
end
