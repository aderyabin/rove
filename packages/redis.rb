Hospice.package :redis do
  title 'Redis'
  category 'Databases'

  cookbook 'redis', :github => 'getaroom/chef-redis'
  recipe 'redis'
end
