# encoding: utf-8

module Hobo
  class << self
    def package(name, &block)
      Package.new(name, &block)
    end

    def template(name, &block)
      Template.new(name, &block)
    end

    def packages
      Package.all
    end

    def categories
      Category.all
    end

    def patterns
      Pattern.all
    end
  end
end

Dir[File.dirname(__FILE__) + "/hobo/*.rb"].each do |file|
  require file
end


Dir[File.dirname(__FILE__) + "/../packages/*.rb"].each do |file|
  require file
end