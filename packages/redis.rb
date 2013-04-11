Hospice.package :redis do
  title 'Redis'
  category 'Databases'

  cookbook 'redis', :github => 'ctrabold/chef-redis'
  recipe 'redis'
end
