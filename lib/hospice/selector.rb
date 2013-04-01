module Hospice
  class Selector
    attr_reader :parent, :package, :name, :options

    def initialize(parent, name, package, &block)
      @parent  = parent
      @name    = name
      @package = package
      @options = []

      instance_eval &block if block_given?
    end

    def id
      object_id
    end

    def option(name, &block)
      @options << @package.ensure_option!(parent, name, package, &block)
    end
  end
end