# frozen_string_literal: true

module Tools
  extend self

  def must_be_reply(bot, message)
    if message.reply_to_message
      yield
    else
      text = "Use this as a reply to someone's message"
      bot.respond_to_user(message, text)
    end
  end

  def must_be_owner(bot, message)
    if message.from_owner?
      yield
    else
      text = "You're not my owner, sorry"
      bot.respond_to_user(message, text)
    end
  end
end
