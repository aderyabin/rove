# encoding: utf-8

require 'erb'
require 'tempfile'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'digest/md5'
require 'json'
require 'pp'

module Rove
  class Builder
    PATH = 'files'

    attr_reader :packages, :recipes, :cookbooks, :build, :config, :vagrant_settings

    class << self
      def [](id)
        path  = File.join(PATH, id)
        build = JSON.load(File.read(path))
        Builder.new(build)
      rescue
        nil
      end

      def <<(build)
        builder = new(build)
        builder.save_to_file
        builder.id
      end
    end

    def initialize(build)
      @build = build.with_indifferent_access

      @packages         = []
      @recipes          = []
      @cookbooks        = []
      @config           = {}
      @vagrant_settings = []

      parse_build!
    end

    def json_text
      @json_text ||= build.to_json
    end

    def path
      @path ||= File.join(PATH, id)
    end

    def id
      @id ||= Digest::MD5.hexdigest(json_text)
    end

    def save_to_file
      unless File.exists?(path)
        FileUtils.mkdir_p(PATH)
        file = File.open(path,"w")
        file.write(json_text)
        file.close
      end
    end

    def zip
      tempfile          = Tempfile.new('rove')
      path              = tempfile.path
      cookbooks         = @cookbooks
      recipes           = @recipes
      config            = @config
      vagrant_settings  = @vagrant_settings
      id                = self.id

      Zip::ZipOutputStream.open(tempfile.path) do |z|
        %w(Vagrantfile Cheffile).each do |t|
          z.put_next_entry t
          z.print ERB.new((template t), nil, '-').result(binding)
        end
      end

      tempfile.close
      path
    end

    private

    def parse_build!
      Rove::Package.all.each do |package|
        parse_package!(package) if @build.include?(package.id)
      end

      Rove::VagrantSetting.all.each do |setting|
        parse_vagrant!(setting) if @build.include?(setting.id)
      end
    end

    def parse_vagrant!(vagrant_setting)
      vagrant_setting.configure parse_vagrant_settings!(vagrant_setting)
      @vagrant_settings << vagrant_setting
    end

    def parse_vagrant_settings!(vagrant_setting)
      config = []

      vagrant_setting.settings.each do |option|
        if @build[vagrant_setting.id].include?(option.id) || option.default
          if @build[vagrant_setting.id].include?(option.id)
            config << @build[vagrant_setting.id][option.id]
          else
            config << option.default
          end
        end
      end
      
      config
    end

    def parse_package!(package)
      @packages  << package
      @cookbooks += package.cookbooks
      @recipes   += package.recipes
      @config.deep_merge! package.configure(@config, @build)
      parse_package_settings!(package)

      config = package.finalize(config)
    end

    def parse_package_settings!(package)
      package.settings.each do |option|
        if @build[package.id].include?(option.id) || option.default
          @cookbooks += option.cookbooks
          @recipes   += option.recipes
          @config.deep_merge! option.configure(@build[package.id][option.id], @config, @build)
        end
      end
    end

    def template(name)
      File.read(File.dirname(__FILE__) + "/templates/#{name}.erb")
    end
  end
end