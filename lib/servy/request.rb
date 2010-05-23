module Servy
  class Request
    attr_accessor :request_method, :request_uri, :http_version, :headers
    
    def initialize(connection)
      parse_request_line(connection.gets.chomp)
      @headers = {}
      while (header = connection.gets.chomp) != ""
        parse_header(header)
      end
    end
    
    private
    def parse_request_line(line)
      request_method, uri, version = line.split(' ')
      @request_method = request_method.downcase.to_sym
      @request_uri = uri
      @http_version = version
    end
    
    def parse_header(header)
      key, value = header.split(':')
      @headers[key.strip] = value.strip
    end
  end
end