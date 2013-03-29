require_relative 'hobo/support/storer'
require_relative 'hobo/builder'
require_relative 'hobo/category'
require_relative 'hobo/cookbook'
require_relative 'hobo/option'
require_relative 'hobo/package'
require_relative 'hobo/pattern'
require_relative 'hobo/selector'

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

    def load!(path)
      Dir["#{path.to_s}/*.rb"].each{|f| require f}
    end
  end
end