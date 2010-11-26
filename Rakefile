require "rake/testtask"

desc "Default: run tests"
task :default => :test

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end
