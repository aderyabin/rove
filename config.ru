require 'sinatra'
require 'sass'
require 'haml'
require 'sprockets'
require 'compass'
require 'sprockets-sass'
require 'bootstrap-sass'
require 'coffee-script'
require 'ap'

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
  @pattern = Rove::Pattern[params[:pattern]] if params[:pattern]

  @build   = @pattern.try(:build)
  @build ||= Rove::Builder[params[:id].try(:strip)].try(:build)
  @build ||= {}

  haml :index
end

get '/install' do
  File.read(File.join('binscripts', 'install'))
end

get '/:id' do
  build = Rove::Builder[params[:id]]

  if build
    send_file build.zip, disposition: :attachment, filename: "rove-#{params[:id]}.zip"
  else
    redirect '/'
  end
end

post '/' do
  if !params['packages']
    return ''
  end

  build = {}

  params['packages'].each do |package, _|
    build[package] = {}

    if params['selects'] && params['selects'][package]
      params['selects'][package].each do |_, option|
        build[package][option] = true
      end
    end

    if params['options'] && params['options'][package]
      params['options'][package].each do |option, value|
        build[package][option] = value.blank? ? true : value
      end
    end
  end

  if params['vagrant_setting']

    params['vagrant_setting'].each do |setting, _|

      build[setting] = {}

      if params['selects'] && params['selects'][setting]
        params['selects'][setting].each do |_, option|
          build[setting][option] = true
        end
      end

      if params['options'] && params['options'][setting]
        params['options'][setting].each do |option, value|

          build[setting][option] = value.blank? ? true : value
          
        end
      end

    end
  end

  Rove::Builder << build
end

run Sinatra::Application