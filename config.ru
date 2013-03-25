require "rubygems"
require "bundler/setup"
require "sinatra"
require "haml"
require "./lib/hobo"
require "./app"

set :run, false
set :port, 3000
set :raise_errors, true

run Sinatra::Application