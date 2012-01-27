require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.libs << '.'
  t.pattern = 'test_*.rb'
end
