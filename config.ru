require 'sinatra'
require 'sass'
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
  @pattern = Hospice::Pattern[params[:pattern]] if params[:pattern]

  @build   = @pattern.try(:build)
  @build ||= Hospice::Builder[params[:id].try(:strip)].try(:build)
  @build ||= {}

  haml :index
end

get '/:id' do
  send_file Hospice::Builder[params[:id]].zip, disposition: :attachment, filename: "hospice-#{params[:id]}.zip"
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

  Hospice::Builder << build
end

run Sinatra::Application