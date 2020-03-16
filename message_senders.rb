module Telegram
  module Bot
    class Client
      def complain_to_owner(text)
        api.send_message(chat_id: Tools::OWNER_ID, text: text)
      end

      def respond_to_user(message, text)
        return nil unless self_can_send_text?(message)

        api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: text, parse_mode: 'HTML')
      end

      def respond_to_target(message, text)
        return nil unless self_can_send_text?(message)

        api.send_message(chat_id: message.chat.id, reply_to_message_id: message.reply_to_message.message_id, text: text, parse_mode: 'HTML')
      end

      def send_message(message, text, no_preview = false)
        return nil unless self_can_send_text?(message)

        if no_preview
          api.send_message(chat_id: message.chat.id, text: text, parse_mode: 'HTML', disable_web_page_preview: true)
        else
          api.send_message(chat_id: message.chat.id, text: text, parse_mode: 'HTML')
        end
      end
    end
  end
end
