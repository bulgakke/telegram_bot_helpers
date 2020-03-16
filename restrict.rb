module Telegram
  module Bot
    class Client
      def mute(message, user_to_mute_id, seconds)
        api.restrict_chat_member(chat_id: message.chat.id, user_id: user_to_mute_id, can_send_messages: false, until_date: Time.now.to_i + seconds)
      end

      def delete(message)
        if self_can_delete_messages?(message)
          api.delete_message(chat_id: message.chat.id, message_id: message.message_id)
        end
      end
    end
  end
end
