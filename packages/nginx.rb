Hospice.package 'Nginx' => 'Server' do
  cookbook 'nginx', :github => 'opscode-cookbooks/nginx'
  recipe 'nginx'
end
