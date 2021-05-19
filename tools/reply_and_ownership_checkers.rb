module Tools
  def must_be_reply(bot, message)
    if message.reply_to_message
      yield
    else
      text = "Use this as a reply to someone's message"
      bot.reply(message, text)
    end
  end

  def must_be_owner(bot, message)
    if message.from_owner?
      yield
    else
      text = "You're not my owner, sorry"
      bot.reply(message, text)
    end
  end

  def must_be_privileged(bot, message)
    if message.from_privileged?
      yield
    else
      text = 'Only privileged users can do this'
      bot.reply(message, text)
    end
  end
end
