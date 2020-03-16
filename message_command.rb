class String
  def starts_with?(command)
    x = command.length - 1
    chars.slice(0..x).join == command
  end

  def command
    chars.each_with_index do |char, index|
      if char == ' '
        @cut_at = index - 1
        break
      elsif index == chars.size - 1
        @cut_at = index
      end
    end

    chars.slice(0..@cut_at).join
  end
end

module Telegram
  module Bot
    module Types
      class Message
        def command(expression)
          return false unless text.class == String

          text.starts_with?(expression)
        end
      end
    end
  end
end
