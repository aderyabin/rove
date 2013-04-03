module Hospice
  class Selector
    attr_reader :parent, :package, :name, :options, :inputs

    def initialize(parent, name, package, &block)
      @parent  = parent
      @name    = name
      @package = package
      @options = []
      @inputs  = []

      instance_eval &block if block_given?
    end

    def id
      object_id
    end

    def option(name, &block)
      @options << @package.ensure_option!(parent, name, package, &block)
    end

    def input(name, &block)
      @inputs << @package.ensure_input!(parent, name, package, &block)
    end
  end
end