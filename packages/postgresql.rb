Hospice.package :postgresql do
  title 'PostgreSQL'
  category 'Databases'

  cookbook 'postgresql', :github => 'express42-cookbooks/postgresql'
  recipe 'postgresql'
end
