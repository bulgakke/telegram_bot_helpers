require 'require_all'
require 'telegram/bot'
require_all '.'

puts 'Successfully started the program in regular mode'

Telegram::Bot::Client.run(token) do |bot|

  bot.listen do |message|
    puts 'Received a message'

    case message.text.command
    when '/start'
      text = 'Greeting, hooman!'
      bot.respond_to_user(message, text)

    when '/get_id'
      Tools::get_id(bot, message)

    when '/poke'
      Tools::must_be_reply(message) do
        user = Tools::form_user_link(message)
        target = Tools::form_target_link(message)
        text = "#{target}, you've just been poked by #{user}!"
        bot.respond_to_target(message, text)
      end

    when '/run_code'
      Tools::must_be_owner(message) do
        text = eval(message.reply_to_message.text) 
        if message.reply_to_message
          begin
            string = eval(message.reply_to_message.text)
            text = string.to_s
          rescue => e
            text = e
          end
          bot.respond_to_target(message, text)
        end
      end
    end
  end
end