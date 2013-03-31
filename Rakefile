task :server do
  exec 'bundle exec rackup'
end

task :console do
  require 'pry'
  require './setup'
  binding.pry
end