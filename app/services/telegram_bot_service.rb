require 'telegram/bot'

class TelegramBotService
  def initialize
    @token = Rails.application.secrets.telegram_bot_token
    @chat_id = Rails.application.secrets.telegram_chat_id
  end
  
  def send(message)
    Telegram::Bot::Client.run(@token) do |bot|
      bot.api.send_message(chat_id: @chat_id, text: message)
    end
  end

  def send_table(tournament)
    Telegram::Bot::Client.run(@token) do |bot|
      bot.api.send_message(chat_id: @chat_id, text: tournament.table)
    end
  end
end
