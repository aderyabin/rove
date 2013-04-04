require 'scorched'
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

class Application < Scorched::Controller
  get '/' do
    @pattern = Hospice::Pattern[request[:pattern]] if request[:pattern]

    @build   = @pattern.try(:build)
    @build ||= Hospice::Builder[request[:id].try(:strip)].try(:build)
    @build ||= {}

    render :'index.haml'
  end

  get '/:id' do
    send_file Hospice::Builder[request.captures[:id]].zip, disposition: :attachment, filename: 'hospice.zip'
  end

  post '/' do
    if !request['packages']
      return ''
    end

    build = {}

    request['packages'].each do |package, _|
      build[package] = {}

      if request['selects'] && request['selects'][package]
        request['selects'][package].each do |_, option|
          build[package][option] = true
        end
      end

      if request['options'] && request['options'][package]
        request['options'][package].each do |option, value|
          build[package][option] = value.blank? ? true : value
        end
      end
    end

    Hospice::Builder << build
  end
end

run Application