module Servy
  class Server
    def initialize(host, port, handler)
      @socket = TCPServer.new(host, port)
      @handler = handler
    end
    
    def start
      while true
        run_once
      end
    end
    
    def run_once
      connection = @socket.accept
      request = Request.new(@connection)
      response = Response.new(request, @handler.new)
      ResponseOutputter.new.output(connection, response)
      connection.close
    end
  end
end