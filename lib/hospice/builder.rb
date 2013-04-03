# encoding: utf-8

require 'erb'
require 'tempfile'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'digest/md5'
require 'json'

module Hospice
  class Builder
    PATH = 'files'

    attr_reader :packages, :recipes, :cookbooks, :configuration, :configs

    def initialize(configuration)
      @configuration = configuration
      @packages = []
      @recipes = []
      @cookbooks = []
      @configs = []
      parse_configuration!
    end

    def self.find(id)
      path = File.join(PATH, id)
      return nil unless File.exist?(path)
      File.open(path, "r") {|f| JSON.load(f)}
    end

    def zip
      tempfile  = Tempfile.new('hospice')
      path      = tempfile.path
      cookbooks = @cookbooks
      recipes   = @recipes
      configs = @configs

      Zip::ZipOutputStream.open(tempfile.path) do |z|
        %w(Vagrantfile Cheffile).each do |t|
          z.put_next_entry t
          z.print ERB.new((template t), nil, '-').result(binding)
        end
      end

      tempfile.close
      path
    end

    def save
      json_text = @configuration.to_json
      filename = Digest::MD5.hexdigest(json_text)
      FileUtils.mkdir_p(PATH)
      file = File.open(File.join(PATH, filename),"w")
      file.write(json_text)
      file.close
      filename
    end

    private

    def parse_configuration!
      Hospice::Package.all.each do |package|
        if @configuration.keys.include?(package.id)
          @packages << package
          parse_package!(package)
        end
      end
      @recipes = @recipes.flatten.compact.uniq
      @cookbooks = @cookbooks.flatten.compact.uniq
      @configs = @configs.flatten.compact.uniq
    end

    def parse_package!(package)
      @cookbooks << package.cookbooks
      @recipes << package.recipes
      @configs << package.config

      package.recursive_options.each do |option|
        if @configuration[package.id].include?(option.id)
          @cookbooks << option.cookbooks
          @recipes << option.recipes
          @configs << option.config
        end
      end
    end

    def template(name)
      File.read(File.dirname(__FILE__) + "/templates/#{name}.erb")
    end
  end
end