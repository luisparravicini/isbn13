require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.libs    = ['lib']
  t.verbose = false
  t.pattern = 'test/test_*.rb'
end

task :gem do
  %x{gem build isbn13.gemspec}
end
