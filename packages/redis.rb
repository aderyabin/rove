# encoding: utf-8

Hobo.package :redis do
  title 'Redis'
  category 'Server'
  cookbook 'redis', :github => 'getaroom/chef-redis'
  recipe 'redis'
end
