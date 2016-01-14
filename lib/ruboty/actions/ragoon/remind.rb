module Ruboty::Actions::Ragoon
  class Remind < ::Ruboty::Actions::Base
    include ::Ruboty::Actions::Ragoon

    def call
      message.reply('[WIP] I will notify event before few minutes')
    end
  end
end
