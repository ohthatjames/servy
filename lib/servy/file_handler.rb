module Servy
  class FileHandler
    attr_accessor :document_root
    
    def initialize(options)
      @options = options
      @document_root = options[:document_root]
    end
    
    def accept(request)
      file_path = File.join(document_root, request.request_uri)
      file_path = File.join(file_path, 'index.html') if File.directory?(file_path)
      if File.exists?(file_path)
        [200, {}, File.read(file_path)]
      else
        [404, {}, "Page not found"]
      end
    end
  end
end