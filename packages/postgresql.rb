# encoding: utf-8

Hobo.package :postgresql do
  title 'PostgreSQL'
  category 'Server'
  cookbook 'postgresql', :github => 'express42-cookbooks/postgresql'
  recipe 'postgresql'
end
