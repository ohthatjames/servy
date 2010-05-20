module Servy
  class Server
    def initialize(host, port)
      @socket = TCPServer.new(host, port)
    end
    
    def start
      while true
        run_once
      end
    end
    
    def run_once
      @connection = @socket.accept
      request = Request.new(@connection)
      @connection.print("HTTP/1.1 200 OK\r\n\r\nHello world\r\n")
      @connection.close
    end
  end
end