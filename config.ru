require 'sinatra'
require 'haml'
require 'sprockets'
require 'compass'
require 'sprockets-sass'
require 'bootstrap-sass'
require 'coffee-script'
 
require './setup'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/images'
  environment.append_path Compass::Frameworks['bootstrap'].templates_directory + '/../vendor/assets/javascripts'
  environment.append_path Compass::Frameworks['bootstrap'].templates_directory + '/../vendor/assets/images'

  environment.context_class.class_eval do
    def asset_path(path, options={})
      "/assets/#{path}"
    end
  end

  run environment
end

get '/' do
  haml :index
end

post '/' do
  raise params.inspect
  builder = Hospice::Builder.new(params['packages'])
  send_file builder.zip, disposition: :attachment, filename: 'hospice.zip'
end

run Sinatra::Application