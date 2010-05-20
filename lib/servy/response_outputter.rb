module Servy
  class ResponseOutputter
    def initialize
      
    end
    
    def output(connection, response)
      connection.print("HTTP/1.1 200 OK\r\n\r\nHello world\r\n")
    end
  end
end