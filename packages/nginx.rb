Hospice.package :nginx do
  category 'Web-Servers'

  cookbook 'nginx', :github => 'opscode-cookbooks/nginx'
  recipe 'nginx'
end
