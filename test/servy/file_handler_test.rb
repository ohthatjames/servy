require File.join(File.dirname(__FILE__), '..', 'test_helper')

class FileHandlerTest < Testy::TestSuite
  class Request
    attr_accessor :request_uri
    
    def initialize(uri)
      @request_uri = uri
    end
  end
  
  def test_returns_document_if_exists
    document_root = File.expand_path(File.join(File.dirname(__FILE__), '..', 'document_root'))
    request = Request.new('/index.html')
    response = Servy::FileHandler.new(:document_root => document_root).accept(request)
    assert_equal([200, {}, "This is the index file"], response)
  end
  
  def test_returns_404_if_document_doesnt_exist
    document_root = File.expand_path(File.join(File.dirname(__FILE__), '..', 'document_root'))
    request = Request.new('/foo.html')
    response = Servy::FileHandler.new(:document_root => document_root).accept(request)
    assert_equal([404, {}, "Page not found"], response)
  end
  
  def test_returns_index_html_if_path_is_directory
    document_root = File.expand_path(File.join(File.dirname(__FILE__), '..', 'document_root'))
    request = Request.new('/')
    response = Servy::FileHandler.new(:document_root => document_root).accept(request)
    assert_equal([200, {}, "This is the index file"], response)
  end
end