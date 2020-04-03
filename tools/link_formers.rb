module Tools
  extend self

  def form_target_link(message, full_name: false)
    return nil unless message.reply_to_message

    @id = message.reply_to_message.from.id
    @first_name = message.reply_to_message.from.first_name
    @last_name = message.reply_to_message.from.last_name
    unless full_name
      return "<a href='tg://user?id=#{@id}'>#{CGI.escapeHTML(@first_name)}</a>"
    end

    "<a href='tg://user?id=#{@id}'>#{CGI.escapeHTML(@first_name)} #{CGI.escapeHTML(@last_name)}</a>"
  end

  def form_user_link(message, full_name: false)
    @id = message.from.id
    @first_name = message.from.first_name
    @last_name = message.from.last_name
    unless full_name
      return "<a href='tg://user?id=#{@id}'>#{CGI.escapeHTML(@first_name)}</a>"
    end

    "<a href='tg://user?id=#{@id}'>#{CGI.escapeHTML(@first_name)} #{CGI.escapeHTML(@last_name)}</a>"
  end
end
