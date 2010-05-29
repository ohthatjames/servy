module Servy
  class Response
    attr_reader :status, :headers, :body
    
    def initialize(request, handler)
      @status, @headers, @body = handler.accept(request)
      add_default_headers
    end
    
    private
    def add_default_headers
      @headers["Content-Length"] ||= @body.length
    end
  end
end