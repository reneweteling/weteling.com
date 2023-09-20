module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect 
      puts "\n\n\tconnect\n\n"
      # p params
    end

  
  end
end
