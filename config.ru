require 'sinatra'
require 'haml'

require './setup'

get '/' do
  haml :index
end

post '/' do
  builder = Hospice::Builder.new(params['packages'])
  send_file builder.zip, :disposition => :attachment, :filename => 'hospice.zip'
end

run Sinatra::Application