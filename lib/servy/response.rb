module Servy
  class Response
    attr_reader :status, :headers, :body
    
    def initialize(request)
      @status = 200
      @body = "Hello world"
    end
  end
end