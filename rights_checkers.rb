# frozen_string_literal: true

module Telegram
  module Bot
    class Client
      def user_can_mute?(message, id)
        chat_member = get_member_info(message, id)
        return true if chat_member['can_restrict_members'] == true

        false
      end

      def user_admin?(message, id)
        chat_member = get_member_info(message, id)
        return true if chat_member['status'] == 'administrator'
        return true if chat_member['status'] == 'creator'

        false
      end

      def user_creator?(message, id)
        chat_member = get_member_info(message, id)
        return true if chat_member['status'] == 'creator'

        false
      end

      def user_can_delete_messages?(message, id)
        chat_member = get_member_info(message, id)
        return true if chat_member['can_delete_messages'] == true

        false
      end

      def self_can_delete_messages?(message)
        user_can_delete_messages?(message, Tools::BOT_ID)
      end

      def self_can_mute?(message)
        user_can_mute?(message, Tools::BOT_ID)
      end

      def user_muted?(message, id)
        chat_member = get_member_info(message, id)
        return true if chat_member['can_send_messages'] == false

        false
      end

      def self_can_send_text?(message)
        !user_muted?(message, Tools::BOT_ID)
      end

      def user_in_chat?(message, id)
        chat_member = get_member_info(message, id)
        return false if chat_member['status'] == 'left'
        return false if chat_member['status'] == 'kicked'
        return false unless chat_member

        true
      end

      def user_can_send_stickers?(message, id)
        chat_member = get_member_info(message, id)
        return true if chat_member['can_send_other_messages'] == true

        false
      end

      private

      def get_member_info(message, id)
        chat_member_hash = api.get_chat_member(chat_id: message.chat.id, user_id: id)
        chat_member_hash['result']
      end
    end
  end
end
