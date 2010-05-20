require 'socket'

module Servy
  class Server
    def initialize(host, port)
      @socket = TCPServer.new(host, port)
    end
    
    def start
      while true
        @connection = @socket.accept
        request = @connection.gets
        @connection.print("HTTP/1.1 200 OK\r\n\r\nHello world\r\n")
        @connection.close
      end
    end
  end
end

if __FILE__ == $0
  Servy::Server.new("localhost", 3000).start
end