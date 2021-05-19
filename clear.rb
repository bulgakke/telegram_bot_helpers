require 'telegram/bot'

puts 'The clearing program started'

token = 'your api token here'

Telegram::Bot::Client.run(token) do |bot|
  puts 'Connected to Telegram'

  bot.listen do |message|
    if message.text.nil? == false && (message.text.include? '/start')
      bot.api.send_message(chat_id: message.chat.id, text: 'Maintenance mode enabled')
      puts '/start received'
    end
  end
end
