require 'rubygems'
require 'testy'

task :default => :test

desc "Run tests"
task :test do
  if ENV["FILE"]
    require File.join(File.dirname(__FILE__), ENV["FILE"])
    Testy::TestSuiteRunner.new(Testy::TestSuite.registered_suites).run
  else
    Testy::TestRunner.new(File.join(File.dirname(__FILE__), 'test', 'servy')).run
  end
end