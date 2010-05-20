$:.unshift File.expand_path(File.dirname(__FILE__))
require 'socket'
require 'servy/server'

if __FILE__ == $0
  Servy::Server.new("localhost", 3000).start
end