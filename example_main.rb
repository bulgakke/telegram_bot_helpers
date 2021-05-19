require 'require_all'
require 'telegram/bot'
require_rel 'tools'
require_relative 'useful_ids'

token = '1043894792:AAFutoMpUfFPgTrL1vej2VgKaiMuMYHMHQ4' # you can declare it in another file or as an environment variable

puts 'Successfully started the program in regular mode'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts 'Received a message'

    case message.command # returns the first word in the text of a message
    when '/start'
      text = 'Greetings, hooman!'
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
        duration = message.text.delete_prefix(message.command).to_i # Example: `/mute 3600` when replying to someone
        bot.mute(message, message.reply_to_message.from.id, duration)
      end

    when '/run_code'
      Tools.must_be_owner(bot, message) do
        # It is highly advisable to not let anyone else do it;
        # You can crash your bot by any syntax error
        Tools.must_be_reply(bot, message) do
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

# Via @BotFather, you'll be able to set the command list for your bot for users to see
# It's convenient to hold it here (@BotFather accepts them in this format):

=begin

start - Says hello
poke - Pokes the person you reply to with it
mute - Mutes a user if the bot has rights to do it

=end
