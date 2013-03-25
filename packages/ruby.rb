# encoding: utf-8

Hobo.package :ruby do
  title 'Ruby'
  category 'Languages'

  cookbook 'rbenv', :github => 'fnichol/chef-rbenv'
  cookbook 'ruby_build', :github => 'fnichol/chef-ruby_build', :ref => 'v0.7.2'
  recipe 'rbenv::user'
  recipe 'ruby_build'
end
