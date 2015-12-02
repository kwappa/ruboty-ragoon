module Ruboty
  module Ragoon
    module Config
      TEMPLATE_DIRS = [
        File.join(Dir.pwd, 'templates'),
        File.join(File.dirname(File.expand_path(__FILE__)), '..', '..', '..', 'templates'),
      ]

      def ragoon_config(key)
        ::Ruboty::Ragoon::Config.const_get(key.to_s.upcase)
      end
    end
  end
end

