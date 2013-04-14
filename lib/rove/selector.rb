module Rove
  class Selector
    attr_reader :parent, :package, :title, :options, :inputs

    def initialize(parent, title, package, &block)
      @parent  = parent
      @title   = title
      @package = package
      @options = []
      @inputs  = []

      instance_eval &block if block_given?
    end

    def id
      object_id
    end

    def option(id, &block)
      @options << @package.ensure_option!(parent, id, package, &block)
    end

    def input(id, &block)
      @inputs << @package.ensure_input!(parent, id, package, &block)
    end
  end
end