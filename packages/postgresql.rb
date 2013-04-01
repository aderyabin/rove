Hospice.package :postgresql do
  title 'PostgreSQL'
  category 'Server'
  cookbook 'postgresql', :github => 'express42-cookbooks/postgresql'
  recipe 'postgresql'
end
