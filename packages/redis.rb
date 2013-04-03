Hospice.package 'Redis' => 'Databases' do
  cookbook 'redis', :github => 'getaroom/chef-redis'
  recipe 'redis'
end
