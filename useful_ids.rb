module Tools
  BOT_ID = 1_043_894_792
  OWNER_ID = 786_714_018
  PRIVILEGED_IDS = [ ]

  def self.get_id(bot, message)
    text = "$$$$$"
    bot.respond_to_user(message, text)
    bot.listen do |response|
      if response.text.starts_with?('$$$$$')
        text = "module Tools
BOT_ID = #{response.from.id}
OWNER_ID = #{message.from.id}
end"
        bot.respond_to_user(message, text)
        text = "Copy-paste this text into your project"
      end
    end
  end
end
