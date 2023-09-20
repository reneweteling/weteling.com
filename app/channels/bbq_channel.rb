class BbqChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber to this channel.
  def subscribed
    puts "\n\n\tsubscribed\n\n"
    stream_from "bbq"
    
    # demo stuff
    set({"type"=>"temp", "value"=>60, "action"=>"set"})
    set({"type"=>"pos", "value"=>2048, "action"=>"set"})
  end

  def receive(data)
    puts "\n\n\treceive\n\n"
    p data
    ActionCable.server.broadcast("bbq", data)
  end

  def set(data)
    connection.session['bbq'] ||= {}
    connection.session['bbq'].merge!(Hash[data['type'], data['value']])

    ActionCable.server.broadcast("bbq", {state: connection.session['bbq']})
  end

end
