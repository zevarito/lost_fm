require 'rubygems'
require 'ruby-debug'
require 'contest'
require 'lib/last_fm'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
