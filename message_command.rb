# frozen_string_literal: true

module Telegram
  module Bot
    module Types
      class Message
        def command
          text.chars.each_with_index do |char, index|
            if char == ' '
              @cut_at = index - 1
              break
            elsif index == chars.size - 1
              @cut_at = index
            end
          end

          text.chars.slice(0..@cut_at).join
        end
      end
    end
  end
end
