class BbqChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber to this channel.
  def subscribed
    puts "\n\n\tsubscribed\n\n"
    stream_from "bbq"
  end

  def receive(data)
    puts "\n\n\treceive\n\n"
    p data
    ActionCable.server.broadcast("bbq", data)
  end
end
