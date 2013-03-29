require 'sinatra'
require 'haml'

require './setup'

get '/' do
  haml :index
end

post '/' do
  builder = Hobo::Builder.new(params['packages'])
  send_file builder.zip, :disposition => :attachment, :filename => 'hobo.zip'
end

run Sinatra::Application