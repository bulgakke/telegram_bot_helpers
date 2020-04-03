module Telegram
  module Bot
    module Types
      class Message
        def from_owner?
          from.id == Tools::OWNER_ID
        end

        def from_privileged?
          from_owner? || Tools::PRIVILEGED_IDS.include?(from.id)
        end

        def from_self?
          from.id == Tools::BOT_ID
        end

        def from_admin?(bot)
          bot.user_admin?(self, from.id)
        end

        def from_creator?(bot)
          bot.user_creator?(self, from.id)
        end
      end
    end
  end
end
