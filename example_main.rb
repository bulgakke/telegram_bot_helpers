# frozen_string_literal: true

require 'require_all'
require 'telegram/bot'
require_all '.'

token = 'your api token here' # you can declare it in another file or as an environment variable

puts 'Successfully started the program in regular mode'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts 'Received a message'

    case message.command # returns the first word in a string
    when '/start'
      text = 'Greeting, hooman!'
      bot.api.send_message(chat_id: message.chat.id, text: text)
      # bot.send_message(message, text) # <= change to this when you'll fill your Bot ID in useful_ids.rb
      # `bot.send_message` checks if bot can send messages before trying to send it

    when '/get_id'
      Tools.get_id(bot, message)

    when '/poke'
      Tools.must_be_reply(bot, message) do
        user = Tools.form_user_link(message)
        target = Tools.form_target_link(message)
        text = "#{target}, you've just been poked by #{user}!"
        bot.respond_to_target(message, text)
      end

    when '/mute'
      Tools.must_be_reply(bot, message) do
        duration = bot.get_duration(message)
        bot.mute(message, message.reply_to_message.from.id, duration)
      end

    when '/run_code'
      Tools.must_be_owner(bot, message) do
        if message.reply_to_message
          begin
            string = eval(message.reply_to_message.text)
            text = string.to_s
          rescue StandardError => e
            text = e
          end
          bot.respond_to_target(message, text)
        end
      end
    end
  end
end
