require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RequestTest < Testy::TestSuite
  class Connection
    def initialize(lines)
      @lines = lines
    end
    
    def gets
      @lines.shift + "\r\n"
    end
  end
  
  def connection(lines = nil)
    Connection.new(lines || ["GET / HTTP/1.1", ""])
  end
  
  def test_parses_method
    assert_equal :get, Servy::Request.new(connection).request_method
  end
  
  def test_parses_non_http_method
    assert_equal :foo, Servy::Request.new(connection(["FOO / HTTP/1.1", ""])).request_method
  end
  
  def test_parses_request_uri
    assert_equal "/", Servy::Request.new(connection).request_uri
  end
  
  def test_parses_version
    assert_equal "HTTP/1.1", Servy::Request.new(connection).http_version
  end
  
  def test_parses_headers
    assert_equal(
      {"Host" => "www.example.com", "User-Agent" => "Blah"}, 
      Servy::Request.new(connection(["FOO / HTTP/1.1", "User-Agent: Blah", "Host: www.example.com", ""])).headers
    )
  end
end