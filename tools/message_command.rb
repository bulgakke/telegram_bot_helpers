module Telegram
  module Bot
    module Types
      class Message
        def command
          text.split[0].delete_suffix(Tools::BOT_USERNAME)
        end
      end
    end
  end
end
