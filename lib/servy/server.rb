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
      connection = @socket.accept
      request = Request.new(@connection)
      response = Response.new(request)
      ResponseOutputter.new.output(connection, response)
      connection.close
    end
  end
end