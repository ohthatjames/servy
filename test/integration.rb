require 'rubygems'
require 'testy'
require 'socket'
require File.join(File.dirname(__FILE__), '..', 'lib', 'servy')

class IntegrationTests < Testy::TestSuite
  def test_returns_hello_world
    thread = Thread.new do
      begin
        server = Servy::Server.new("localhost", 9999)
      rescue Exception => e
        puts e.inspect
      end
    end
    socket = TCPSocket.open("localhost", 9999)
    socket.print("GET /foo HTTP/1.1\r\n\r\n")
    response = socket.read
    assert("Hello world" == response.strip)
  ensure
    thread.kill
    socket.close
  end
end