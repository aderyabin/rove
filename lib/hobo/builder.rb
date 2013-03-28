# encoding: utf-8
require 'erb'
require 'tempfile'
require 'zip/zip'
require 'zip/zipfilesystem'

module Hobo
  class Builder
    def initialize(params)
      @packages = Hobo::Package.all.select { |package| params.include?(package.name.to_s)}
    end

    def packages
      @packages
    end

    def recipes
      @recipes ||= packages.collect(&:recipes).flatten.uniq
    end

    def cookbooks
      @cookbooks ||= packages.inject({}){ |result, package| result.merge package.cookbooks }
    end

    def zip
      tempfile = Tempfile.new('hobo')
      path = tempfile.path
      cookbooks = self.cookbooks
      recipes = self.recipes

      Zip::ZipOutputStream.open(tempfile.path) do |z|
        z.put_next_entry('Vagrantfile')
        z.print ERB.new(File.read(File.dirname(__FILE__) +"/../../files/Vagrantfile.erb")).result(binding)

        z.put_next_entry('Cheffile')
        z.print ERB.new(File.read(File.dirname(__FILE__) +"/../../files/Cheffile.erb")).result(binding)
      end

      tempfile.close
      path
    end
  end
end