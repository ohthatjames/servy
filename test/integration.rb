require File.join(File.dirname(__FILE__), 'test_helper')

class IntegrationTests < Testy::TestSuite
  class HelloWorldHandler
    def accept(request)
      [200, {"Foo" => "Bar", "A" => "B"}, "Hello world"]
    end
  end
  def test_returns_hello_world
    thread = Thread.new do
      begin
        Servy::Server.new("localhost", 9999, HelloWorldHandler).start
      rescue Exception => e
        puts e.inspect
      end
    end
    socket = TCPSocket.open("localhost", 9999)
    socket.print("GET /foo HTTP/1.1\r\nUser-Agent: Me\r\n\r\n")
    response = socket.read
    assert_equal("HTTP/1.1 200 OK\r\nA: B\r\nFoo: Bar\r\n\r\nHello world\r\n", response)
  ensure
    thread.kill
    socket.close
  end
end