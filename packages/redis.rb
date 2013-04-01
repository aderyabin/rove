Hospice.package 'Redis' => 'Server' do
  cookbook 'redis', :github => 'getaroom/chef-redis'
  recipe 'redis'
end
