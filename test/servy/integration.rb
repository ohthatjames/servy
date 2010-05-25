require File.join(File.dirname(__FILE__), '..', 'test_helper')

class IntegrationTests < Testy::TestSuite
  class HelloWorldHandler
    def initialize(options)
      
    end
    
    def accept(request)
      [200, {"Foo" => "Bar", "A" => "B"}, "Hello world"]
    end
  end
  
  # def test_returns_hello_world
    # response = make_request(HelloWorldHandler, {}, "GET /foo HTTP/1.1\r\nUser-Agent: Me\r\n\r\n")
    # assert_equal("HTTP/1.1 200 OK\r\nA: B\r\nFoo: Bar\r\n\r\nHello world\r\n", response)
  # end
  
  def test_file_handler
    document_root = File.expand_path(File.join(File.dirname(__FILE__), '..', 'document_root'))
    response = make_request(Servy::FileHandler, {:document_root => document_root}, "GET /index.html HTTP/1.1\r\nUser-Agent: Me\r\n\r\n")
    assert_equal("HTTP/1.1 200 OK\r\n\r\nThis is the index file\r\n", response)
  end
  
  def make_request(handler, options, request)
    thread = Thread.new do
      begin
        Servy::Server.new("localhost", 9999, handler, options).start
      rescue Exception => e
        puts e.inspect
        puts e.backtrace.join("\n")
      end
    end
    socket = TCPSocket.open("localhost", 9999)
    socket.print(request)
    return socket.read
  ensure
    thread.kill!
    socket.close
  end
end