require 'erb'
require 'tempfile'
require 'zip/zip'
require 'zip/zipfilesystem'

module Hospice
  class Builder
    def initialize(params)
      @packages = Hospice::Package.all.select{ |package| params.include?(package.name.to_s) }
    end

    def packages
      @packages
    end

    def recipes
      @recipes ||= packages.collect(&:recipes).flatten.uniq
    end

    def cookbooks
      @cookbooks ||= packages.collect(&:cookbooks).flatten.uniq
    end

    def zip
      tempfile  = Tempfile.new('hospice')
      path      = tempfile.path
      cookbooks = self.cookbooks
      recipes   = self.recipes

      Zip::ZipOutputStream.open(tempfile.path) do |z|
        %w(Vagrantfile Cheffile).each do |t|
          z.put_next_entry t
          z.print ERB.new(template t).result(binding)
        end
      end

      tempfile.close
      path
    end

    def template(name)
      File.read(File.dirname(__FILE__) + "/templates/#{name}.erb")
    end
  end
end