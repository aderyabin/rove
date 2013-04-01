Hospice.package :redis do
  title 'Redis'
  category 'Server'
  cookbook 'redis', :github => 'getaroom/chef-redis'
  recipe 'redis'
end
