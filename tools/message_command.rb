module Telegram
  module Bot
    module Types
      class Message
        def command
          return '' unless text
          text.split[0].delete_suffix(Tools::BOT_USERNAME)
        end
      end
    end
  end
end
