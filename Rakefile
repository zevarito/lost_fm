require "rake/testtask"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "lost_fm"
    gem.summary = %Q{Library to access LastFM api.}
    gem.description = %Q{Library to access LastFM api.}
    gem.rubyforge_project = "lost_fm"
    gem.email = "zevarito@gmail.com"
    gem.homepage = "http://github.com/zevarito/lost_fm"
    gem.authors = ["Alvaro Gil"]
    gem.add_dependency 'json'
    gem.add_dependency 'hashie'
    gem.add_development_dependency "contest"
    gem.add_development_dependency "fakeweb"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

desc "Default: run tests"
task :default => :test

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end
