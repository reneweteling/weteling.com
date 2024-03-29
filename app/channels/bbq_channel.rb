class BbqChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber to this channel.
  @@state = {}
  def subscribed
    stream_from "bbq"
    
    # # demo stuff
    # set({"type"=>"temp", "value"=>60, "action"=>"set"})
    # set({"type"=>"pos", "value"=>2048, "action"=>"set"})
  end

  def receive(data)
    ActionCable.server.broadcast("bbq", data)
  end

  def update(data)
    @@state.merge!(data.except("action"))

    ActionCable.server.broadcast("bbq", {state: @@state})
  end
end
