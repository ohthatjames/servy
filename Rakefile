require 'rubygems'
require 'testy'

task :default => :test

desc "Run tests"
task :test do
  Testy::TestRunner.new(File.join(File.dirname(__FILE__), 'test')).run
end