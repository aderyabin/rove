require_relative 'hospice/support/storer'
require_relative 'hospice/builder'
require_relative 'hospice/category'
require_relative 'hospice/cookbook'
require_relative 'hospice/option'
require_relative 'hospice/input'
require_relative 'hospice/package'
require_relative 'hospice/pattern'
require_relative 'hospice/selector'

module Hospice
  class << self
    def package(id, &block)
      Package.new(id, &block)
    end

    def pattern(title, &block)
      Pattern.new(title, &block)
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

    def [](id)
      Package[id]
    end
  end
end