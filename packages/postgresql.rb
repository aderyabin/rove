Hospice.package 'PostgreSQL' => 'Server' do
  cookbook 'postgresql', :github => 'express42-cookbooks/postgresql'
  recipe 'postgresql'
end
