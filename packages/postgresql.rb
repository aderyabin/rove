Hospice.package 'PostgreSQL' => 'Databases' do
  cookbook 'postgresql', :github => 'express42-cookbooks/postgresql'
  recipe 'postgresql'
end
