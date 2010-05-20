require File.join(File.dirname(__FILE__), '..', 'test_helper')
class ResponseOutputterTest < Testy::TestSuite
  Struct.new("Response", :status, :headers, :body)
  
  def response(options = {})
    defaults = {:status => 200, :headers => {}, :body => ""}
    options = defaults.merge(options)
    Struct::Response.new(options[:status], options[:headers], options[:body])
  end
  
  def test_prints_http_version
    connection = StringIO.new
    Servy::ResponseOutputter.new.output(connection, response)
    assert_connection_matches(connection, %r{^HTTP/1.1})
  end
  
  def test_prints_status_code_and_message
    connection = StringIO.new
    Servy::ResponseOutputter.new.output(connection, response)
    assert_connection_matches(connection, %r{200 OK})
  end
  
  def test_500_status_code_and_message
    connection = StringIO.new
    Servy::ResponseOutputter.new.output(connection, response(:status => 500))
    assert_connection_matches(connection, %r{500 Internal Server Error})
  end
  
  def test_outputs_body_after_two_line_breaks
    connection = StringIO.new
    Servy::ResponseOutputter.new.output(connection, response(:body => "Foo bar"))
    assert_connection_matches(connection, %r{\r\n\r\nFoo bar\r\n$})
  end
  
  def assert_connection_matches(connection, regex)
    connection.rewind
    result = connection.read =~ regex
    assert(!result.nil?)
  end
end