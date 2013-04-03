Hospice.package 'Nginx' => 'Servers' do
  cookbook 'nginx', :github => 'opscode-cookbooks/nginx'
  recipe 'nginx'
end
