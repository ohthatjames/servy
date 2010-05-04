require 'socket'

module Servy
  class Server
    def initialize(host, port)
      @socket = TCPServer.new(host, port)
      @connection = @socket.accept
      request = @connection.gets
      @connection.puts("Hello world")
      @connection.close
    end
  end
end