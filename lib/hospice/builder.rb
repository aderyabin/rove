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

    attr_reader :packages, :recipes, :cookbooks, :build, :config

    class << self
      def [](id)
        path  = File.join(PATH, id)
        build = JSON.load(File.read(path))
        Builder.new(build)
      rescue
        nil
      end

      def <<(build)
        json_text = build.to_json
        filename = Digest::MD5.hexdigest(json_text)
        path = File.join(PATH, filename)

        unless File.exists?(path)
          FileUtils.mkdir_p(PATH)
          file = File.open(path,"w")
          file.write(json_text)
          file.close
        end

        filename
      end
    end

    def initialize(build)
      @build = build.with_indifferent_access

      @packages   = []
      @recipes    = []
      @cookbooks  = []
      @config     = {}

      parse_build!
    end

    def zip
      tempfile  = Tempfile.new('hospice')
      path      = tempfile.path
      cookbooks = @cookbooks
      recipes   = @recipes
      config    = @config

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
      Hospice::Package.all.each do |package|
        parse_package!(package) if @build.include?(package.id)
      end
    end

    def parse_package!(package)
      @packages  << package
      @cookbooks += package.cookbooks
      @recipes   += package.recipes
      @config.deep_merge! package.configure(@build, @config)

      package.settings.each do |option|
        if @build[package.id].include?(option.id)
          @cookbooks += option.cookbooks
          @recipes   += option.recipes
          @config.deep_merge! option.configure(@build[package.id][option.id], @build, @config)
        end
      end

      config = package.finalize(config)
    end

    def template(name)
      File.read(File.dirname(__FILE__) + "/templates/#{name}.erb")
    end
  end
end