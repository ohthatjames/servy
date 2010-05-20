module Servy
  class Response
    attr_reader :status, :headers, :body
    
    def initialize(request, handler)
      @status, @headers, @body = handler.accept(request)
    end
  end
end