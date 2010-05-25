module Servy
  class FileHandler
    attr_accessor :document_root
    
    def initialize(options)
      @options = options
      @document_root = options[:document_root]
    end
    
    def accept(request)
      file_path = File.join(document_root, request.request_uri)
      if File.exists?(file_path)
        [200, {}, File.read(file_path)]
      else
        [404, {}, "Page not found"]
      end
    end
  end
end