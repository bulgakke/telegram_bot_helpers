Telegram Bot API official documentation: https://core.telegram.org/bots

The wrapper used here: https://github.com/atipugin/telegram-bot-ruby

This guide is mostly about the stuff you'll type in the editor building the logic of your bot. If you want to learn about Telegram, how its group chats work, how to edit the bot account or how to deploy it, use other sources.

# Setup:
 - Create your bot account at @BotFather in Telegram. You'll receive an API token which you'll use to connect to your bot account from this program.
 - In main.rb:7, assign this value to the `token` variable as a `String`.
 - Run `gem install telegram-bot-ruby` or add `gem 'telegram-bot-ruby'` to your Gemfile.
 - Optional: do the same with the `require_all` gem; otherwise you'll have to require all the files by standard Ruby means.
 - Run your main.rb file, you should see `Successfully started the program in regular mode` in your console.
 - In Telegram, send `/start` to your bot. Then, reply (not forward!) to his message with `/get_id` command: he will send you the IDs of yours and of his account.
   - For example, if your bot tries to send a message in a chat it's banned from, it will crash. For that reason, the methods described in `message_senders.rb` check if the bot can send messages before trying to do so; to check it, the bot needs to know the ID of its account, and I haven't found any way to access it without storing it in a file or getting from a message you know came from the bot account.

# Other:
 - If your bot does crash, it is usually stuck trying to finish the task it cannot do (it will be happening on the Telegram side). For that reason, the `clear.rb` file exists, you'll need to run it instead of `main.rb` so that your bot will "forget" the previous task.
 - The context revolves around the `message` object. From it, bot understands in which chat he does the logic you write (further in this README, 'current chat' is `message.chat`), who the sender is, etc. Read more in the official documentation.
 - Look carefully at the list of arguments custom methods accept. Most of them will need `bot`, `message` or both objects to do anything. Keep this in mind when building your own methods.
 - Telegram doesn't allow more than one connection with the same API token.

# Methods:

## Telegram::Bot::Types::Message
Call these on the `message` object inside of the `bot.listen do |message|` block. 

 - `#command` 

 Returns the first word in the message text (or the whole text if there's no whitespace). Use when getting the /command from a message.

 - `#from_owner?`

 Returns `true` if the message is sent by the bot owner (configured at `/tools/useful_ids.rb`).
 - `#from_privileged?`

 Returns `true` if the message is sent by anyone you meintioned in the `PRIVILEGED_IDS` array at `/tools/useful_ids.rb`.
 - `#from_self?`

 Returns `true` if the message is sent by the bot (configured at `/tools/useful_ids.rb`).
 - `#from_admin?(bot)`

 Returns `true` if the message sender is an admin or the creator in the current chat.
 - `#from_creator?(bot)`

 Returns `true` if the message sender is the creator of the current chat.

 ## Telegram::Bot::Client
 Call these on the `bot` object. These are mostly shortcuts for everything you find in the API documentation (to call those, use `#api.method_name` on the `bot`). You'll often need to pass as an argument the `message` in the context of which your logic will be happening.

  - `#complain_to_owner(text)`

  Sends a private message to the bot owner account.
  - `#respond_to_user(message, text)`

  Replies to the sender of the current `message` in the current chat.
  - `#respond_to_target(message, text)`

  Replies to the sender of the message current `message` replies to in the current chat.
  - `#send_message(message, text, no_preview: false)`

  Sends a message in the current chat. Set `no_preview: true` to disable the web page preview in the resulting message.

  - Private: `#get_member_info(message, id)`

  Fixes the `#api.get_chat_member` method, returns what that method is supposed to return. 

  - `#user_can_mute?(message, id)`

  Returns `true` if the user with `id` can restrict non-admin members in the current chat.
  - `#user_admin?(message, id)`

  Returns `true` if the user is an admin or the creator in the current chat.
  - `#user_creator?(message, id)`

  Returns `true` if the user is the creator in the current chat.
  - `#user_can_delete_messages?(message, id)`

  Returns `true` if the user can delete messages in the current chat.
  - `#self_can_delete_messages?(message)`

  Returns `true` if the bot can delete messages in the current chat.
  - `#self_can_mute?(message)`

  Returns `true` if the bot can restrict non-admin members in the current chat.
  - `#user_muted?(message, id)`

  Returns `true` if the user cannot send any messages in the current chat.
  - `#self_can_send_text?(message)`

  Returns `true` if the bot can send text messages in the current chat. By Telegram group chat restrictions, if a user can send any messages at all, they can always send text messages.
  - `#user_in_chat?(message, id)`

  Returns `true` if the user is in the current chat. Returns `false` if left, kicked or never been here at all.
  - `#user_can_send_stickers?(message, id)`

  Returns `true` if the user can send stickers in the current chat.

  - `#mute(message, user_to_mute_id, seconds)`

  If has the rights to do so, restricts the non-admin user with `user_to_mute_id` from sending messages in the current chat for `seconds` seconds. Else, replies to the `message` sender saying it can't.
  - `#delete(message)`

  If has the rights to do so, deletes the message to which the current `message` is a reply. Else, replies to the command sender saying it can't.

## Tools
Call these on the `Tools` module. Usually these encapsulate often used routine stuff.

  - `::must_be_reply(bot, message, &block)`

  Executes the `&block` if the `message` is a reply to a valid message. Else, replies to the sender saying this command must be used in a reply.
  - `::must_be_owner(bot, message, &block)`

  Executes the `&block` if the `message` comes from the owner of the bot. Else, replies to the sender saying this command can only be used by the owner.
  - `::must_be_privileged(bot, message, &block)`

  Executes the `&block` if the `message` comes from a privileged account (configured manually at Tools::PRIVILEGED_IDS) or the owner. Else, replies to the sender blah-blah-blah you get it

  - `::form_user_link(message, full_name: false)`
  - `::form_target_link(message, full_name: false)`

  Returns a string, which, when sent in a message, becomes a hyperlink to the profile with the Telegram first name (full name if `full_name: true`). 
  User if the sender of the `message`, target is the sender of the message the current `message` replies to.

