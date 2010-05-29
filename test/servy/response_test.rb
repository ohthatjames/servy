require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ResponseOutputterTest < Testy::TestSuite
  class Handler
    attr_reader :accepted
    def initialize
      @accepted = []
    end
    
    def accept(request)
      @accepted << request
      [200, {"foo" => "bar"}, "Blah"]
    end
  end
  
  def setup
    @handler = Handler.new
  end
  
  def test_response_delegates_request_to_handler
    response = Servy::Response.new(:request, @handler)
    assert_equal([:request], @handler.accepted)
  end
  
  def test_returns_status
    response = Servy::Response.new(:request, @handler)
    assert_equal(200, response.status)
  end
  
  def test_returns_headers
    response = Servy::Response.new(:request, @handler)
    assert_equal({"foo" => "bar", "Content-Length" => 4}, response.headers)
  end
  
  def test_returns_body
    response = Servy::Response.new(:request, @handler)
    assert_equal("Blah", response.body)
  end
end