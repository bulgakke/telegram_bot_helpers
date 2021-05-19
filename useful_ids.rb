module Tools
  # BOT_ID = 9_999_999_999
  # OWNER_ID = 999_999_999
  BOT_USERNAME = '@yourbotnameherebot'
  PRIVILEGED_IDS = [].freeze

  def get_id(bot, message)
    unless message.reply_to_message
      text = 'Use this command as a reply to my message'
      bot.api.send_message(chat_id: message.chat.id, text: text)
      return
    end

    text = "BOT_ID = #{message.reply_to_message.from.id} \nOWNER_ID = #{message.from.id}"
    bot.api.send_message(chat_id: message.chat.id, text: text)
    text = 'Add these into your project in `useful_ids.rb`'
    bot.api.send_message(chat_id: message.chat.id, text: text)
  end
end
